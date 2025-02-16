import 'package:hive_flutter/hive_flutter.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

import '../core/constants.dart';
import 'models/task_category.dart';
import 'models/task_model.dart';
import 'models/task_priority.dart';
import 'models/user_model.dart';

class LocalStorage {
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      
      // Register adapters in correct order
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TaskAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(TaskPriorityAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(UserAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(TaskCategoryAdapter());
      }
      
      // Close boxes if they're already open
      await _closeBoxes();
      
      // Open boxes
      await _openBoxes();
      
      debugPrint('Hive initialization successful');
    } catch (e) {
      debugPrint('Error initializing Hive: $e');
      rethrow;
    }
  }

  static Future<void> _closeBoxes() async {
    if (Hive.isBoxOpen(AppConstants.taskBoxKey)) {
      await Hive.box(AppConstants.taskBoxKey).close();
    }
    if (Hive.isBoxOpen(AppConstants.userBoxKey)) {
      await Hive.box(AppConstants.userBoxKey).close();
    }
  }

  static Future<void> _openBoxes() async {
    await Hive.openBox<Task>(AppConstants.taskBoxKey);
    await Hive.openBox<User>(AppConstants.userBoxKey);
  }

  static Box<Task> getTaskBox() {
    if (!Hive.isBoxOpen(AppConstants.taskBoxKey)) {
      throw StateError('Task box is not open');
    }
    return Hive.box<Task>(AppConstants.taskBoxKey);
  }

  static Box<User> getUserBox() {
    if (!Hive.isBoxOpen(AppConstants.userBoxKey)) {
      throw StateError('User box is not open');
    }
    return Hive.box<User>(AppConstants.userBoxKey);
  }

  static Stream<List<Task>> watchTasks() {
    final box = getTaskBox();
    return box.watch().map((_) => box.values.toList());
  }

  static Future<void> addTask(Task task) async {
    final box = getTaskBox();
    await box.put(task.id, task);
  }

  static Future<void> updateTask(Task task) async {
    final box = getTaskBox();
    await box.put(task.id, task);
  }

  static Future<void> deleteTask(String id) async {
    final box = getTaskBox();
    await box.delete(id);
  }

  static List<Task> getTasks() {
    final box = getTaskBox();
    return box.values.toList();
  }

  static Task? getTask(String id) {
    final box = getTaskBox();
    return box.get(id);
  }

  static Future<void> clearAllData() async {
    await _closeBoxes();
    await Hive.deleteBoxFromDisk(AppConstants.taskBoxKey);
    await Hive.deleteBoxFromDisk(AppConstants.userBoxKey);
    await _openBoxes();
  }
} 