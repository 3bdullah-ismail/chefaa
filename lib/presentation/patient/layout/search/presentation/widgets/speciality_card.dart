import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityCard extends StatelessWidget {
  final Map<String, String> item;

  const SpecialityCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context, item["specialityName"]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            item["specialityImage"]!,
            width: double.infinity,
            height:135.h,
          ),
          Text(
            item["specialityName"]!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}