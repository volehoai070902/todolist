
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/log/logger_custom.dart';
import 'package:todo_list/state/constants/firebase_collection_name.dart';
import 'package:todo_list/state/constants/firebase_field_name.dart';
import 'package:todo_list/state/tasks/model/task_payload.dart';

class TaskController{
  TaskController();
  final CollectionReference collection = FirebaseFirestore.instance.collection(FirebaseCollectionName.tasks);
  
  Future<void> deleteTask(String? docId)async{
    await collection.doc(docId).delete();
  }

  Future<bool> addTaskToDo(
    {
      required String title,
      required String subtitle,
      required String date,
      required String time,
      required String status,
      required String category
    }
  )async {
    try{

      final taskPayload = TaskPayload(title: title, subtitle: subtitle, date: date, time: time, status: status, category: category);
      final task = await collection.add(taskPayload);
      
      return true;
    }catch(_){
      return false;
    }
  }

  void updateTask({
      required String id,
      String ?subtitle,
      String ?title,
      DateTime ?date,
      TimeOfDay ?time,
      String ?status,
      String ?category
    }){
      collection.doc(id).update({
        FirebaseFieldName.taskStatus: status
      });
  }
  
  Future<bool> updateTaskToDo(
    {
      required String id,
      String ?subtitle,
      String ?title,
      DateTime ?date,
      TimeOfDay ?time,
      String ?status,
      String ?category
    }
  )async{
    try{
      await collection.doc(id).update({
        FirebaseFieldName.taskStatus: status
      });
      // final task = await collection.where(FieldPath.documentId,isEqualTo: id).limit(1).get();
      // await task.docs.first.reference.update({
      //   FirebaseFieldName.taskTitle: title,
      //   FirebaseFieldName.taskSubtitle:subtitle,
      //   FirebaseFieldName.taskDate:date,
      //   FirebaseFieldName.taskTime:time,
      //   FirebaseFieldName.taskStatus:status,
      //   FirebaseFieldName.taskCategory: category
      // });
      return true;
    } catch(e){
      return false;
    }   
  }

  Future<List<TaskPayload>> readAllTaskToDo()async{
    try{
      List<TaskPayload> list_tasks = [];
      final tasks = await collection.get();
      final Stream<QuerySnapshot> tasksStream = collection.snapshots();
      
      
      tasks.docs.forEach((element) {
        TaskPayload taskPayload = TaskPayload(
          title: element.get('title'),
          subtitle: element.get('subtitle'),
          category: element.get('category'),
          date : element.get('date'),
          status: element.get('status'),
          time: element.get('time'),
        );
        list_tasks.add(taskPayload);
      }) ;
      return list_tasks;
    }catch(e){
      return [];
    }
  }
}