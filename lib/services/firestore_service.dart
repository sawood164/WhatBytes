import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';

import '../data/models/task_model.dart';
import 'firebase_auth_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();

  // Get tasks collection reference
  CollectionReference<Map<String, dynamic>> get _tasksCollection =>
      _firestore.collection('tasks');

  // Add new task
  Future<void> addTask(Task task) async {
    await _tasksCollection.doc(task.id).set(task.toFirestore());
  }

  // Update task
  Future<void> updateTask(Task task) async {
    await _tasksCollection.doc(task.id).update(task.toFirestore());
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }

  // Get user's tasks
  Stream<List<Task>> getUserTasks() {
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

  // Toggle task completion
  Future<void> toggleTaskStatus(Task task) async {
    await _tasksCollection.doc(task.id).update({
      'isCompleted': !task.isCompleted,
    });
  }
} 