import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';

BoxDecoration premiumCardDecoration() {
  return BoxDecoration(
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(color: ColorManager.black.withAlpha(40), blurRadius: 10),
    ],
  );
}
