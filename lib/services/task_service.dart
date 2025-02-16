import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:uuid/uuid.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:wha_bytes/firebase_options.dart';

import '../data/models/task_category.dart';
import '../data/models/task_model.dart';
import '../data/models/task_priority.dart';
import 'firebase_auth_service.dart';

class TaskService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuthService _auth = FirebaseAuthService();

  static CollectionReference<Map<String, dynamic>> get _tasksCollection =>
      _firestore.collection('tasks');

  static Future<Task> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required TaskPriority priority,
    required TaskCategory category,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
      category: category,
      userId: userId,
    );

    await _tasksCollection.doc(task.id).set(task.toFirestore());
    return task;
  }

  static Future<void> updateTask(Task task) async {
    await _tasksCollection.doc(task.id).update(task.toFirestore());
  }

  static Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }

  static Stream<List<Task>> watchTasks() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _tasksCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromFirestore(doc.data()))
          .toList();
    });
  }

  static Future<void> addTask(Task task) async {
    await _tasksCollection.doc(task.id).set(task.toFirestore());
  }

  static Future<void> toggleTaskStatus(Task task) async {
    await _tasksCollection.doc(task.id).update({
      'isCompleted': !task.isCompleted,
    });
  }
} 