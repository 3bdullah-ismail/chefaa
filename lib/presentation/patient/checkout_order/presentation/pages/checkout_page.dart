import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/checkout_summary_card.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/delivery_card.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/delivery_form.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/get_config.dart';
import '../../../../../core/widget/inside_app_bar.dart';
import '../../../order/presentation/pages/track_order_page.dart';
import '../../../payment/presentation/pages/payment_page.dart';
import '../../../pharmacy/pharmacies/presentation/manager/pharmacy_checkout_cubit.dart';
import '../widgets/continue_btn.dart';
import '../widgets/custom_card.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String paymentMethod = "cod";

  double subtotal = 37.5;
  double delivery = 15.0;

  double get total => subtotal + delivery;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();

  bool _didInit = false;
  String? pharmacyId;
  List<Map<String, dynamic>> items = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInit) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        pharmacyId = args['pharmacyId'] as String?;
        items = List<Map<String, dynamic>>.from(args['items'] ?? []);
        subtotal = (args['subtotal'] as num?)?.toDouble() ?? 37.5;
        delivery = (args['deliveryFee'] as num?)?.toDouble() ?? 15.0;
      }
      _didInit = true;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(
          title: "Checkout",
          subtitle: "Enter your delivery and payment information",
        ),
      ),
      body: BlocProvider<PharmacyCheckoutCubit>(
        create: (context) => getIt<PharmacyCheckoutCubit>(),
        child: BlocConsumer<PharmacyCheckoutCubit, PharmacyCheckoutState>(
          listener: (context, state) {
            if (state is PharmacyCheckoutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.response.message),
                  backgroundColor: ColorManager.primary,
                ),
              );
              if (paymentMethod == "online") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentPage()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const TrackOrderPage()),
                );
              }
            } else if (state is PharmacyCheckoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorManager.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is PharmacyCheckoutLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                children: [
                  20.verticalSpace,
                  const CustomCard(title: "Delivery Method", child: DeliveryCard()),
                  15.verticalSpace,
                  CustomCard(
                    title: "Delivery Information",
                    child: DeliveryForm(
                      nameController: nameController,
                      phoneController: phoneController,
                      cityController: cityController,
                      streetController: streetController,
                    ),
                  ),
                  15.verticalSpace,
                  CustomCard(
                    title: "Payment Method",
                    child: PaymentCard(
                      paymentMethod: paymentMethod,
                      cashOnTap: () {
                        setState(() {
                          paymentMethod = "cod";
                        });
                      },
                      onlineOnTap: () {
                        setState(() {
                          paymentMethod = "online";
                        });
                      },
                    ),
                  ),
                  15.verticalSpace,
                  CheckoutSummaryCard(
                    subtotal: subtotal,
                    delivery: delivery,
                    total: total,
                  ),
                  25.verticalSpace,
                  ContinueBtn(
                    isLoading: isLoading,
                    onPressed: () {
                      if (nameController.text.trim().isEmpty ||
                          phoneController.text.trim().isEmpty ||
                          cityController.text.trim().isEmpty ||
                          streetController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all delivery details"),
                            backgroundColor: ColorManager.error,
                          ),
                        );
                        return;
                      }

                      final checkoutData = {
                        "pharmacyId": pharmacyId ?? "6a0a13efd785cd1a6461b64c",
                        "orderType": "Delivery",
                        "paymentMethod": paymentMethod == "cod" ? "Cash" : "Visa",
                        "items": items.map((item) => {
                          "medicineId": item["medicineId"] ?? "6a0a2dfc4fdc199ce495e74b",
                          "medicineName": item["name"] ?? item["medicineName"] ?? "",
                          "quantity": item["quantity"] ?? 1,
                        }).toList(),
                        "deliveryAddressDetails": {
                          "fullName": nameController.text.trim(),
                          "phoneNumber": phoneController.text.trim(),
                          "cityDistrict": cityController.text.trim(),
                          "streetAddress": streetController.text.trim(),
                          "location": {
                            "type": "Point",
                            "coordinates": [31.2357, 30.0444]
                          }
                        }
                      };

                      context.read<PharmacyCheckoutCubit>().checkoutOrder(checkoutData);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
