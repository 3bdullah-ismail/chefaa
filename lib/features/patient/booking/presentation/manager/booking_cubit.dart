import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/search/domain/entities/clinic_model.dart';
import 'package:chefaa/features/patient/booking/data/models/booking.dart';
import 'package:chefaa/features/patient/booking/data/models/slots.dart';
import 'package:chefaa/features/patient/booking/domain/repositories/booking_repo.dart';
import 'booking_state.dart';


@injectable
class BookingCubit extends Cubit<BookingState> {
  final BookingRepo bookingRepo;

  BookingCubit(this.bookingRepo) : super(BookingInitialState());

  static BookingCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ClinicModel? selectedClinic;

  DateTime? selectedDay;

  String? selectedDate;
  String? selectedTime;

  List<Slots> slots = [];
  Booking? booking;

  int activeStep = 0;
  final PageController pageController = PageController();

  PaymentMethod? selectedPaymentMethod;

  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  final cardNumberController = TextEditingController();
  final cardHolderNameController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();


  void selectClinic(ClinicModel clinic) {
    selectedClinic = clinic;
    slots.clear();
    selectedDate = null;
    selectedTime = null;
    selectedDay = null;
      if (!isClosed) emit(ChangeStepState());
  }

  bool get canChooseTime => selectedClinic != null;


  void updateSelectedDate(DateTime date) {
    selectedDay = date;

    final clinicId = selectedClinic?.clinicId;
    if (clinicId == null) return;

    getDaySlots(
      clinicId: clinicId,
      date: date,
    );
      if (!isClosed) emit(ChangeStepState());
  }

  void selectDay(DateTime date) {
    updateSelectedDate(date);
  }


  Future<void> getDaySlots({
    required String clinicId,
    required DateTime date,
  }) async {
      if (!isClosed) emit(GetSlotsLoadingState());

    try {
      selectedDate = DateFormat('yyyy-MM-dd').format(date);

      slots = await bookingRepo.getDaySlots(
        clinicId: clinicId,
        date: selectedDate!,
      );
      if (!isClosed) emit(GetSlotsSuccessState(slots));
    }catch (e) {
      if (e is ServerFailure) {
      if (!isClosed) emit(GetSlotsErrorState(e.message));
      } else {
      if (!isClosed) emit(GetSlotsErrorState(ServerFailure.unexpectedError));
      }
    }
  }


  void selectTime(String time) {
    selectedTime = time;
      if (!isClosed) emit(TimeSelectedState(time));
  }


  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
      if (!isClosed) emit(ChangeStepState());
  }

  bool get needsCard =>
      selectedPaymentMethod == PaymentMethod.creditCard;

  bool onConfirmBookingPressed() {
    if (needsCard) {
      return cardFormKey.currentState?.validate() ?? false;
    }
    return true;
  }


  Future<void> bookAppointment({
    required String clinicId,
    required bool isFollowUp,
    required String paymentOption,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? cardholderName,
  }) async {
    if (selectedDate == null || selectedTime == null) {
      if (!isClosed) emit(BookingErrorState(error: "Please select date and time first."));
      return;
    }
      if (!isClosed) emit(BookingLoadingState());

    try {
      final result = await bookingRepo.bookAppointment(
        clinicId: clinicId,
        date: selectedDate!,
        time: selectedTime!,
        isFollowUp: isFollowUp,
        paymentOption: paymentOption,
        paymentStatus: "pending",

        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        cvv: cvv,
        cardholderName: cardholderName,
      );

      booking = result;
      if (!isClosed) emit(BookingSuccessState(message: booking!.message));
    }catch (e) {
      if (e is ServerFailure) {
      if (!isClosed) emit(BookingErrorState(error: e.message));
      } else {
      if (!isClosed) emit(BookingErrorState(error: ServerFailure.unexpectedError));
      }
    }
  }


  void nextStep() {
    if (activeStep < 3) {
      activeStep++;
      pageController.animateToPage(
        activeStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (!isClosed) emit(ChangeStepState());
    }
  }

  void previousStep() {
    if (activeStep > 0) {
      activeStep--;
      pageController.animateToPage(
        activeStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (!isClosed) emit(ChangeStepState());
    }
  }

  void goToStep(int index) {
    activeStep = index;
      if (!isClosed) emit(ChangeStepState());
  }
}

enum PaymentMethod {

  creditCard,
  cash,
}