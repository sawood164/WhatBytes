import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';

import '../data/local_storage.dart';
import '../data/models/task_model.dart';

class TaskRepository {
  final taskBox = LocalStorage.getTaskBox();

  Future<void> addTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }

  List<Task> getAllTasks() {
    return taskBox.values.toList();
  }

  Task? getTask(String id) {
    return taskBox.get(id);
  }
} 