import 'package:flutter/material.dart';

class BoxTask extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String time;
  const BoxTask({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time
  });

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
          Expanded(flex: 1, child: Container()),
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
                        onChanged: (value){},
                        value: true,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey)),
                    ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.shade200,
                  ),
            
                  Text("${date}  ${time}")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}