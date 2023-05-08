import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class QuickSearchTextFieldWidget extends StatelessWidget {
  const QuickSearchTextFieldWidget({
    super.key,
    required this.controller,
    required this.searchFunction,
    required this.formKey,
  });

  final TextEditingController controller;
  final Function searchFunction;
  final GlobalKey formKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextField(
        key: formKey,
        onChanged: (_) => searchFunction(context),
        controller: controller,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: constants.BORDER_COLOR,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: constants.BORDER_COLOR,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: const Icon(
            Icons.arrow_back_ios_new,
            color: constants.DEEP_BORDER_COLOR,
            size: 13,
          ),
        ),
      ),
    );
  }
}
