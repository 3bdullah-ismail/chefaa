import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityCard extends StatelessWidget {
  final Map<String, String> item;

  const SpecialityCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, item["specialityName"]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 105.h,
            width: 105.w,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              item["specialityImage"]!,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          Text(item["specialityName"]!, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
