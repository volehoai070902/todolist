import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/tasks/model/task_payload.dart';
import 'package:todo_list/state/tasks/provider/task_provider.dart';
import 'package:todo_list/views/components/task/add_new_task.dart';
import 'package:todo_list/views/main/provider/load_date_provider.dart';
import 'package:todo_list/views/widgets/box_task_widget.dart';
import 'package:intl/intl.dart';

final selectedOptionsProvider = StateProvider<int>((ref) => 0); 
class MainView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(

        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              CustomAppBar(),
              HeaderOfBody(),
              ListOfCategory(),
              Expanded(child: ListOfTask())
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfTask extends ConsumerWidget {
  const ListOfTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(fetchStreamProvider);
    final selected = ref.watch(selectedOptionsProvider);
    print(selected);
    List<TaskPayload>? list = task.value;
    if (selected == 1){
      list = task.value?.map<TaskPayload>((e){
        final date_1 = DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(e.date));
        final date_2 = DateFormat('EEEE, d MMM, yyyy').format(DateTime.now());
        if (date_1 == date_2){
          return e;
        }
        return TaskPayload.unknown();
      }).toList();
    }
    if (selected == 2){
      list = task.value?.map<TaskPayload>((e){
        final date_1 = DateTime.parse(e.date);
        final date_2 = DateTime.now();
        final time_1 = TimeOfDay.fromDateTime(date_1);
        final time_2 = TimeOfDay.fromDateTime(date_2);
        if (date_1.isAfter(date_2)){
          return e;
        }

        if (e.time.compareTo(time_2.format(context)) > 0 && DateFormat('EEEE, d MMM, yyyy').format(date_1).compareTo(DateFormat('EEEE, d MMM, yyyy').format(date_2)) == 0){
          return e;
        }
        return TaskPayload.unknown();
      }).toList();
    }

    if (list != null){
      list.removeWhere((element) => element.id == 'Unknown');
    }
    
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Consumer(
        builder: (context, ref, child) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    TaskPayload? taskPayload = list?.elementAt(index);

                    DateTime date;
                    if (taskPayload != null) {
                      date = DateTime.parse(taskPayload.date);
                      return BoxTask(
                          id:taskPayload.id ,
                          title: taskPayload.title,
                          subtitle: taskPayload.subtitle,
                          date: DateFormat("EEEE").format(date),
                          time: taskPayload.time,
                        );
                    }
                  },
                  childCount: list?.length,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

enum ListCategory{
  All,
  Today,
  Upcoming
}

class ListOfCategory extends ConsumerWidget{
  @override
  Widget build (BuildContext content, WidgetRef ref){
    final selected = ref.watch(selectedOptionsProvider);
    List<Widget> listCategory = [];
    for(int i = 0; i < ListCategory.values.length; i++){
      Color color = Colors.grey.shade200;
      if (selected == i){
        color = Color(0xFFD5E8FA);
      }
      listCategory.add(TabBarText(
        onPressed: (){
          ref.read(selectedOptionsProvider.notifier).state = i;
        }, 
        text: ListCategory.values.elementAt(i).name,
        color: color,
        ));
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: listCategory
      ),
    );
  }
  
}



class TabBarText extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  const TabBarText({
    super.key,
    required this.onPressed,
    required this.text,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color
      ),
      onPressed: onPressed, 
      child: Text(text,style: TextStyle(
        color: Colors.blue.shade800
      ),
      )
    );
  }
} 

class HeaderOfBody extends ConsumerWidget {
  const HeaderOfBody({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Text(
                "Today's Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                ref.watch(loadDateProvider),
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD5E8FA),
                foregroundColor: Colors.blue.shade800,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
            onPressed: () => showModalBottomSheet(
              enableDrag: true,
              elevation: 0,
              isDismissible: false,
              backgroundColor: Colors.white,
              isScrollControlled: true,
              context: context,
              builder: (context) => AddNewTaskModel(),
            ),
            child: Text("+ New Task"),
          ),
        )
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.bottomCenter,
      height: 120,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage("assets/images/avatar.png"),
        ),
        title: Text(
          "Hello, I\'m",
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
        subtitle: Text(
          "Le Hoai",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {},
                icon: ImageIcon(AssetImage("assets/images/calendar.png"))),
            IconButton(
                onPressed: () {},
                icon: ImageIcon(AssetImage("assets/images/notification.png")))
          ],
        ),
      ),
    );
  }
}

// Row(
//           children: [
//             IconButton(
//             onPressed: () {},
//             icon: ImageIcon(AssetImage("assets/images/calendar.png"))),
//           IconButton(
//             onPressed: () {},
//             icon: ImageIcon(AssetImage("assets/images/notification.png")))
//           ],
//         )