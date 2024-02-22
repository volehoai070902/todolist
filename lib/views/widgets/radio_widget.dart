import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/views/components/task/model/category_model.dart';
import 'package:todo_list/views/components/task/providers/category_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    super.key,
    required this.categColor,
    required this.titleRadio,
    required this.valueInput
  });

  final String titleRadio;
  final Color categColor;
  final Category valueInput;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryProvider);
    return Material(
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: categColor
        ),
        child: RadioListTile(
          activeColor: categColor,
          fillColor: MaterialStateColor.resolveWith((states) => categColor),
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(offset: const Offset(-22, 0),child: Text(titleRadio, style: TextStyle(
            color: categColor, fontWeight: FontWeight.w700, fontSize: 12
          ),),),
          value: valueInput, 
          groupValue: category, 
          onChanged: (value){
            ref.read(categoryProvider.notifier).state = value as Category;
          }),
      ),
    );
  }
}