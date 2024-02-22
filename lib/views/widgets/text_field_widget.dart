
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/views/components/task/providers/text_field_provider.dart';

class TextFieldWidget extends ConsumerWidget {
  final String ?hintText;
  final int? maxLines;
  final ValueChanged<String> onChanged;

  TextFieldWidget({
    super.key,
    this.hintText,
    required this.maxLines,
    required this.onChanged
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        onChanged: onChanged,
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