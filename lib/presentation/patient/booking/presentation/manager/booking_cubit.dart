import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import '../../../../../core/error_handling/failure.dart';
import '../../../search/domain/entities/clinic_model.dart';
import '../../data/models/booking.dart';
import '../../data/models/slots.dart';
import '../../data/repositories/booking_repo.dart';
import '../pages/choose_visit_type.dart';
import 'booking_state.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  final BookingRepo bookingRepo;

  BookingCubit(this.bookingRepo) : super(BookingInitialState());

  static BookingCubit get(BuildContext context) => BlocProvider.of(context);

  ClinicModel? selectedClinic;

  DateTime? selectedDay;

  String? selectedDate;
  String? selectedTime;

  List<Slots> slots = [];
  Booking? booking;

  int activeStep = 0;
  final PageController pageController = PageController();

  VisitType? selectedVisitType;
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

    emit(ChangeStepState());
  }

  bool get canChooseTime => selectedClinic != null;

  void updateSelectedDate(DateTime date) {
    selectedDay = date;

    final clinicId = selectedClinic?.clinicId;
    if (clinicId == null) return;

    getDaySlots(clinicId: clinicId, date: date);

    emit(ChangeStepState());
  }

  void selectDay(DateTime date) {
    updateSelectedDate(date);
  }

  Future<void> getDaySlots({
    required String clinicId,
    required DateTime date,
  }) async {
    emit(GetSlotsLoadingState());

    try {
      selectedDate = DateFormat('yyyy-MM-dd').format(date);

      slots = await bookingRepo.getDaySlots(
        clinicId: clinicId,
        date: selectedDate!,
      );

      emit(GetSlotsSuccessState(slots));
    } catch (e) {
      if (e is ServerFailure) {
        emit(GetSlotsErrorState(e.message));
      } else {
        emit(GetSlotsErrorState(ServerFailure.unexpectedError));
      }
    }
  }

  void selectTime(String time) {
    selectedTime = time;
    emit(TimeSelectedState(time));
  }

  void selectVisitType(VisitType type) {
    selectedVisitType = type;
    emit(ChangeStepState());
  }

  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    emit(ChangeStepState());
  }

  bool get needsCard => selectedPaymentMethod == PaymentMethod.creditCard;

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
      emit(BookingErrorState(error: "Please select date and time first."));
      return;
    }

    emit(BookingLoadingState());

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

      emit(BookingSuccessState(message: booking!.message));
    } catch (e) {
      if (e is ServerFailure) {
        emit(BookingErrorState(error: e.message));
      } else {
        emit(BookingErrorState(error: ServerFailure.unexpectedError));
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
      emit(ChangeStepState());
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
      emit(ChangeStepState());
    }
  }

  void goToStep(int index) {
    activeStep = index;
    emit(ChangeStepState());
  }
}

enum PaymentMethod { creditCard, cash }
