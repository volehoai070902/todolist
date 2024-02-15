
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String ?hintText;
  final int? maxLines;
  const TextFieldWidget({
    super.key,
    this.hintText,
    required this.maxLines
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
        ),
        maxLines: maxLines,
      ),
    );
  }
}