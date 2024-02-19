
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/state/constants/firebase_field_name.dart';

class TaskPayload extends MapView<String,dynamic>{
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String status;
  final String category;
  TaskPayload({
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

  factory TaskPayload.fromSnapshot(QueryDocumentSnapshot<Object?> doc){
    return TaskPayload(title: doc['title'], subtitle: doc['subtitle'], date: doc['date'], time: doc['time'], status: doc['status'], category: doc['category']);
  }
}