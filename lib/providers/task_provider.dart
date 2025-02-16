import 'package:flutter/material.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';

import '../data/models/task_model.dart';
import '../services/firestore_service.dart';

class TaskProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  bool _isLoading = true;
  String _searchQuery = '';

  List<Task> get tasks => _searchQuery.isEmpty ? _tasks : _filteredTasks;
  bool get isLoading => _isLoading;

  TaskProvider() {
    _loadTasks();
  }

  void _loadTasks() {
    _isLoading = true;
    notifyListeners();

    _firestoreService.getUserTasks().listen((tasks) {
      _tasks = tasks;
      if (_searchQuery.isNotEmpty) {
        searchTasks(_searchQuery);
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  void searchTasks(String query) {
    _searchQuery = query.toLowerCase().trim();
    if (_searchQuery.isEmpty) {
      _filteredTasks = [];
    } else {
      _filteredTasks = _tasks.where((task) {
        final titleMatch = task.title.toLowerCase().contains(_searchQuery);
        final descriptionMatch = task.description.toLowerCase().contains(_searchQuery);
        final priorityMatch = task.priority.name.toLowerCase().contains(_searchQuery);
        final categoryMatch = task.category.name.toLowerCase().contains(_searchQuery);
        
        return titleMatch || descriptionMatch || priorityMatch || categoryMatch;
      }).toList();
    }
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _firestoreService.addTask(task);
    if (_searchQuery.isNotEmpty) {
      searchTasks(_searchQuery); // Re-apply search filter
    }
    notifyListeners();
  }

  Future<void> toggleTaskStatus(Task task) async {
    await _firestoreService.toggleTaskStatus(task);
    if (_searchQuery.isNotEmpty) {
      searchTasks(_searchQuery); // Re-apply search filter
    }
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    await _firestoreService.deleteTask(taskId);
    if (_searchQuery.isNotEmpty) {
      searchTasks(_searchQuery); // Re-apply search filter
    }
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _firestoreService.updateTask(task);
    if (_searchQuery.isNotEmpty) {
      searchTasks(_searchQuery);
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredTasks = [];
    notifyListeners();
  }
} 