import 'package:chefaa/core/widget/custom_app_bar.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class DocSignUp extends StatelessWidget {
   DocSignUp({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(175),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: controller,
            text: "Email",
            prefixIcon: "",
          ),
        ],
      ),
    );
  }
}
