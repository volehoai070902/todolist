import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/tasks/provider/task_provider.dart';


class BoxTask extends StatefulWidget {
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String ?id;
  
  const BoxTask({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    this.id,
  });

  @override
  State<BoxTask> createState() => _BoxTaskState();
}

class _BoxTaskState extends State<BoxTask> {
  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15)),
      width: double.infinity,
      height: 130,
      child: Row(
        children: [
          //color line
          Expanded(flex: 1, child: Container(
          )),
          if (checkbox)
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey
                ),
                child: Consumer(builder: (context, ref, child) {
                  return IconButton(
                  onPressed: () {
                    if (checkbox){
                      ref.read(task_provider).deleteTask(widget.id);
                    }
                  },
                  icon: Icon(Icons.delete_outlined),
                  );
                },) 
              ),
            ),
          //content of 1 task
          Expanded(
            flex: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title and subtitle
                  ListTile(
                    trailing: Transform.scale(
                      scale: 1,
                      child: Checkbox(
                        shape: const CircleBorder(),
                        activeColor: Colors.blue.shade800,
                        onChanged: (value){
                          setState(() {
                            checkbox = !checkbox;
                          });
                        },
                        value: checkbox,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      widget.subtitle,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey)),
                    ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.shade200,
                  ),
            
                  Text("${widget.date}  ${widget.time}")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}