import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/views/components/task/model/category_model.dart';
import 'package:todo_list/views/components/task/providers/date_picker_provider.dart';
import 'package:todo_list/views/components/task/providers/time_picker_provider.dart';
import 'package:todo_list/views/widgets/radio_widget.dart';
import 'package:todo_list/views/widgets/text_field_widget.dart';

class AddNewTaskModel extends StatelessWidget {
  const AddNewTaskModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.70,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "New Task Todo",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            const Gap(12),
            const Text(
              "Title Task",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(6),
            TextFieldWidget(
              maxLines: 1,
              hintText: "Add Task Name..",
            ),
            const Gap(12),
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(6),
            TextFieldWidget(
              maxLines: 5,
              hintText: "Add Task Name..",
            ),
            const Gap(12),
            const Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: RadioWidget(
                  categColor: Colors.green,
                  titleRadio: "Learning",
                  valueInput: Category.Learning,
                )),
                Expanded(
                    child: RadioWidget(
                  categColor: Colors.blue,
                  titleRadio: "Working",
                  valueInput: Category.Working,
                )),
                Expanded(
                    child: RadioWidget(
                  categColor: Colors.yellow,
                  titleRadio: "General",
                  valueInput: Category.General,
                )),
              ],
            ),
            const Gap(12),
            const Text(
              "Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final dateLabel = ref.watch(datePickerProvider);
                    final time = dateLabel!.day.toString() + "-" +dateLabel!.month.toString()+"-"+dateLabel!.year.toString();
                    return DateWidget(
                      imageUrl: "assets/images/calendar.png",
                      label: time,
                      ontap: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024, 1, 1),
                            lastDate: DateTime(2025, 12, 24));
                        ref.read(datePickerProvider.notifier).state = date;
                      },
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final timeLabel = ref.watch(timePickerProvider);
                    
                    return DateWidget(
                      imageUrl: "assets/images/clock.png",
                      label: timeLabel.format(context),
                      ontap: () async{
                        final timeofday = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                         
                        ref.read(timePickerProvider.notifier).state = timeofday as TimeOfDay;
                      } ,
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade500,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.blue.shade500),
                    ),
                  ),
                ),
                Gap(20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Create"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade500,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.blue.shade500)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  final String label;
  final String imageUrl;
  final VoidCallback? ontap;
  const DateWidget(
      {super.key, required this.imageUrl, required this.label, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: ElevatedButton.icon(
        onPressed: ontap,
        icon: ImageIcon(AssetImage(imageUrl)),
        label: Text(label),
        style: ElevatedButton.styleFrom(foregroundColor: Colors.blue),
      ),
    );
  }
}
