
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/state/constants/firebase_field_name.dart';

class TaskPayload extends MapView<String,dynamic>{
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String status;
  final String category;
  final String ?id;
  TaskPayload({
    this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.status,
    required this.category
  }):super({
    FirebaseFieldName.taskTitle: title,
    FirebaseFieldName.taskSubtitle:subtitle,
    FirebaseFieldName.taskDate: date,
    FirebaseFieldName.taskTime:time,
    FirebaseFieldName.taskStatus:status,
    FirebaseFieldName.taskCategory:category
  });


  factory TaskPayload.unknown() {
    return TaskPayload(
      id: "Unknown",
      title: 'Unknown',
      subtitle: 'Unknown',
      date: 'Unknown',
      time: 'Unknown',
      status: 'Unknown',
      category: 'Unknown',
    );
  }
  factory TaskPayload.fromSnapshot(QueryDocumentSnapshot<Object?> doc){
    return TaskPayload(id: doc.id,title: doc['title'], subtitle: doc['subtitle'], date: doc['date'], time: doc['time'], status: doc['status'], category: doc['category']);
  }
}