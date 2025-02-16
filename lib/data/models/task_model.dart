import 'package:hive/hive.dart';
import 'package:wha_bytes/data/models/task_category.dart';
import 'package:wha_bytes/data/models/task_priority.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  TaskPriority priority;

  @HiveField(7)
  TaskCategory category;  // Changed back to public for Hive

  @HiveField(8)
  final String userId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.category,
    this.isCompleted = false,
    DateTime? createdAt,
    required this.userId,
  }) : this.createdAt = createdAt ?? DateTime.now();

  TaskCategory getEffectiveCategory() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final weekEnd = today.add(const Duration(days: 7));

    final taskDate = DateTime(dueDate.year, dueDate.month, dueDate.day);

    if (taskDate.isAtSameMomentAs(today)) {
      return TaskCategory.today;
    } else if (taskDate.isAtSameMomentAs(tomorrow)) {
      return TaskCategory.tomorrow;
    } else if (taskDate.isAfter(today) && taskDate.isBefore(weekEnd)) {
      return TaskCategory.thisWeek;
    }
    return TaskCategory.thisWeek;
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority.name,
      'category': category.name,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }

  factory Task.fromFirestore(Map<String, dynamic> doc) {
    return Task(
      id: doc['id'],
      title: doc['title'],
      description: doc['description'],
      dueDate: (doc['dueDate'] as Timestamp).toDate(),
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == doc['priority'],
      ),
      category: TaskCategory.values.firstWhere(
        (e) => e.name == doc['category'],
      ),
      isCompleted: doc['isCompleted'],
      userId: doc['userId'],
    );
  }
} 