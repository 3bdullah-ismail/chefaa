import 'package:flutter/material.dart';

class MedicineSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String query;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const MedicineSearchBar({
    super.key,
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,

      decoration: InputDecoration(
        hintText: "Search medicine",

        prefixIcon: const Icon(Icons.search_rounded),

        suffixIcon: query.isNotEmpty
            ? IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.cancel_rounded),
              )
            : null,
      ),
    );
  }
}
