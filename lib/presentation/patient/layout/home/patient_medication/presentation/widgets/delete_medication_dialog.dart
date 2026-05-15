import 'package:flutter/material.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
class DeleteMedicationDialog {
  static Future<void> show({
    required BuildContext context,
    required String medicationId,
    required dynamic cubit,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: ColorManager.lightGray,
        title: Text(
          "Confirm Deletion",
          style: getBoldStyle(color: ColorManager.primary, fontSize: 22),
        ),
        content: Text(
          "Are you sure?",
          style: getRegularStyle(color: ColorManager.black, fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: getMediumStyle(color: ColorManager.gray, fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deleteMedication(medicationId);
            },
            child: Text(
              "Delete",
              style: getMediumStyle(color: ColorManager.error, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
