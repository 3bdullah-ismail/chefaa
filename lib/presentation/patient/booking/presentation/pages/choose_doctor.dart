import 'package:chefaa/presentation/patient/booking/presentation/widgets/title_text.dart';
import 'package:flutter/material.dart';

import '../widgets/sub_text.dart';

class ChooseDoctor extends StatelessWidget {
  const ChooseDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleText(text: "Choose Doctor"),
          const SubText(text: "Select your healthcare provider."),
          Container(
            width: 396,
            height: 147,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Image
                    CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(
                        "https://placehold.co/54x54",
                      ),
                    ),

                    SizedBox(width: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DR. Ahmed Ali',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF101623),
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'Internal Medicine Specialist',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF525863),
                          ),
                        ),

                        SizedBox(height: 6),

                        Row(
                          children: [
                            Text(
                              '4.8',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '(145)',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF707784),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// Price
                    Text(
                      '150 E£',
                      style: TextStyle(fontSize: 14, color: Color(0xFF0065A3)),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Divider(color: Color(0xFFE5E7EB)),

                SizedBox(height: 8),

                Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0065A3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
