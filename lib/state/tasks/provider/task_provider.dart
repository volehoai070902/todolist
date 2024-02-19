import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/constants/firebase_collection_name.dart';
import 'package:todo_list/state/tasks/backend/task_controller.dart';
import 'package:todo_list/state/tasks/model/task_payload.dart';

final task_provider = StateProvider((ref) => TaskController());
final fetchStreamProvider = StreamProvider<List<TaskPayload>>((ref) async*{
  final taskProvider = ref.watch(task_provider);
  final data = FirebaseFirestore.instance.collection(FirebaseCollectionName.tasks).snapshots().map((event) => event.docs.map((snapshot) => TaskPayload.fromSnapshot(snapshot)).toList(),);
  // print("task  $taskProvider");
  // final data = await taskProvider.readAllTaskToDo();
  yield* data;
});