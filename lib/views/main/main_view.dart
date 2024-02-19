import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/provider/auth_state_provider.dart';
import 'package:todo_list/state/auth/provider/user_id_provider.dart';
import 'package:todo_list/state/tasks/model/task_payload.dart';
import 'package:todo_list/state/tasks/provider/task_provider.dart';
import 'package:todo_list/views/components/task/add_new_task.dart';
import 'package:todo_list/views/widgets/box_task_widget.dart';
import 'package:intl/intl.dart';

class MainView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              HeaderOfBody(),
              const Gap(20),
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
    return Consumer(
      builder: (context, ref, child) {
        return SafeArea(
          child: CustomScrollView(
            
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    TaskPayload? taskPayload = task.value?.elementAt(index);
                    DateTime date;
                    if (taskPayload != null){
                      date = DateTime.parse(taskPayload.date);
                      return BoxTask(title: taskPayload.title, subtitle: taskPayload.subtitle, date: DateFormat("EEEE").format(date), time: taskPayload.time);
                    }
                  },
                  childCount: task.value?.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class HeaderOfBody extends StatelessWidget {
  const HeaderOfBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                "Today's Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Wednesday, 11 May",
                style: TextStyle(fontSize: 13, color: Colors.grey),
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ListTile(
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
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: ImageIcon(AssetImage("assets/images/calendar.png"))),
        IconButton(
            onPressed: () {},
            icon: ImageIcon(AssetImage("assets/images/notification.png")))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
