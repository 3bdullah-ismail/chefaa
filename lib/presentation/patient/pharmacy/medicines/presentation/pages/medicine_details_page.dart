import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../cart/presentation/pages/cart_page.dart';
import '../widgets/active_monograph_content.dart';
import '../widgets/bio_chem_specification_card.dart';
import '../widgets/floating_transaction_hub.dart';
import '../widgets/hero_banner.dart';
import '../widgets/identity_medicine_card.dart';
import '../widgets/interactive_purchase_card.dart';
import '../widgets/monograph_filter_row.dart';
import '../widgets/section_header.dart';
import '../widgets/usage_instructions_matrix.dart';

class MedicineDetailsPage extends StatefulWidget {
  final String name;
  final String activeIngredient;
  final String price;

  const MedicineDetailsPage({
    super.key,
    required this.name,
    required this.activeIngredient,
    required this.price,
  });

  @override
  State<MedicineDetailsPage> createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  int _quantity = 1;
  double _unitPrice = 0;
  String _currencySign = "EGP";
  String _selectedSection = "Overview";

  @override
  void initState() {
    super.initState();
    _parsePriceString();
  }

  void _parsePriceString() {
    try {
      final cleanedPrice = widget.price.replaceAll(RegExp(r'[^0-9.]'), '');

      _unitPrice = double.parse(cleanedPrice);

      if (widget.price.toLowerCase().contains("egp")) {
        _currencySign = "EGP";
      } else if (widget.price.contains(r"$")) {
        _currencySign = r"$";
      }
    } catch (_) {
      _unitPrice = 0;
    }
  }

  double get _totalPrice => _unitPrice * _quantity;

  void _triggerCartNotification(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$_quantity Pack(s) of ${widget.name} added to cart.',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff059669),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                HeroBanner(
                  onBack: () => Navigator.pop(context),
                  onCart: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p20,
                        vertical: AppPadding.p28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IdentityMedicineCard(
                            name: widget.name,
                            activeIngredient: widget.activeIngredient,
                          ),

                          25.verticalSpace,

                          InteractivePurchaseCard(
                            currencySign: _currencySign,
                            unitPrice: _unitPrice,
                            quantity: _quantity,
                            onIncrement: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            onDecrement: () {
                              setState(() {
                                if (_quantity > 1) {
                                  _quantity--;
                                }
                              });
                            },
                          ),

                          const SizedBox(height: 28),

                          const SectionHeader(title: "Usage Instructions"),

                          const SizedBox(height: 12),

                          const UsageInstructionsMatrix(),

                          const SizedBox(height: 32),

                          const SectionHeader(title: "Chemical Profile"),

                          const SizedBox(height: 12),

                          const BioChemSpecificationCard(),

                          const SizedBox(height: 32),

                          const SectionHeader(title: "Clinical Information"),

                          const SizedBox(height: 14),

                          MonographFilterRow(
                            selectedSection: _selectedSection,
                            onChanged: (section) {
                              setState(() {
                                _selectedSection = section;
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          ActiveMonographContent(
                            selectedSection: _selectedSection,
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          FloatingTransactionHub(
            totalPrice: _totalPrice,
            currencySign: _currencySign,
            quantity: _quantity,
            onAddToCart: () => _triggerCartNotification(context),
          ),
        ],
      ),
    );
  }
}
