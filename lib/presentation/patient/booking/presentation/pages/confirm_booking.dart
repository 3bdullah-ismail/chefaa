import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/presentation/patient/booking/presentation/pages/choose_visit_type.dart';
import 'package:chefaa/presentation/patient/booking/presentation/widgets/sub_text.dart';
import 'package:chefaa/presentation/patient/booking/presentation/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../manager/booking_provider.dart';
import '../widgets/confirm_booking/appointment_card.dart';
import '../widgets/confirm_booking/payment_card_form.dart';
import '../widgets/confirm_booking/payment_methods_card.dart';

class ConfirmBooking extends StatelessWidget {
  const ConfirmBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: "Review & Confirm"),
              8.verticalSpace,
              const SubText(text: "Check your appointment details"),
              32.verticalSpace,

              AppointmentCard(provider: provider),

              24.verticalSpace,
              if (provider.selectedVisitType == VisitType.clinic)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(text: "Payment Methods"),
                    4.verticalSpace,
                    const SubText(text: "Choose the best way to pay"),
                    16.verticalSpace,
                  ],
                ),
              PaymentMethodsCard(
                title: "Credit Card",
                image: "assets/images/card_image.png",
                isSelected:
                    provider.selectedPaymentMethod == PaymentMethod.creditCard,
                isGroupHeader: provider.needsCard && provider.showCardForm,
                onTap: () =>
                    provider.selectPaymentMethod(PaymentMethod.creditCard),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: (provider.needsCard && provider.showCardForm)
                    ? PaymentCardForm(
                        formKey: provider.cardFormKey,
                        cardNumberController: provider.cardNumberController,
                        cardHolderNameController:
                            provider.cardHolderNameController,
                        expiryDateController: provider.expiryDateController,
                        cvvController: provider.cvvController,
                        borderColor: ColorManager.primary,
                        borderWidth: 2,
                        removeTopBorder: true,
                        showShadow: false,
                      )
                    : const SizedBox.shrink(),
              ),
              if (provider.selectedVisitType == VisitType.clinic)
                Column(
                  children: [
                    16.verticalSpace,
                    PaymentMethodsCard(
                      image: "assets/images/cash.png",
                      title: "Cash",
                      isSelected:
                          provider.selectedPaymentMethod == PaymentMethod.cash,
                      onTap: () =>
                          provider.selectPaymentMethod(PaymentMethod.cash),
                    ),
                  ],
                ),
              32.verticalSpace,

              if (provider.selectedPaymentMethod != null)
                Column(
                  children: [
                    CustomBtn(
                      text: "Continue",
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        final canProceed = provider.onConfirmBookingPressed();
                        if (!canProceed) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Continue…')),
                        );
                      },
                    ),
                    12.verticalSpace,
                    Text(
                      "By confirming, you agree to our terms and cancellation policy",
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
