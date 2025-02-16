import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/presentation/widgets/task_period_section.dart';

import '../../data/models/task_model.dart';
import '../../providers/task_provider.dart';

class TaskPeriodsGrid extends StatelessWidget {
  const TaskPeriodsGrid({super.key});

  List<Task> _getTodayTasks(List<Task> tasks) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return tasks.where((task) {
      final taskDate = DateTime(
        task.dueDate.year,
        task.dueDate.month,
        task.dueDate.day,
      );
      return taskDate.isAtSameMomentAs(today);
    }).toList();
  }

  List<Task> _getTomorrowTasks(List<Task> tasks) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    return tasks.where((task) {
      final taskDate = DateTime(
        task.dueDate.year,
        task.dueDate.month,
        task.dueDate.day,
      );
      return taskDate.isAtSameMomentAs(tomorrow);
    }).toList();
  }

  List<Task> _getWeekTasks(List<Task> tasks) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekEnd = today.add(const Duration(days: 7));
    return tasks.where((task) {
      final taskDate = DateTime(
        task.dueDate.year,
        task.dueDate.month,
        task.dueDate.day,
      );
      return taskDate.isAfter(today) && taskDate.isBefore(weekEnd);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final tasks = taskProvider.tasks;
          final todayTasks = _getTodayTasks(tasks);
          final tomorrowTasks = _getTomorrowTasks(tasks);
          final weekTasks = _getWeekTasks(tasks);

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              children: [
                TaskPeriodSection(
                  title: 'Today',
                  taskCount: todayTasks.length,
                  completedTasks: todayTasks.where((t) => t.isCompleted).length,
                  color: const Color(0xFF6366F1),
                  icon: Icons.today_rounded,
                  onTap: () {
                    // TODO: Filter tasks for today
                  },
                ),
                TaskPeriodSection(
                  title: 'Tomorrow',
                  taskCount: tomorrowTasks.length,
                  completedTasks: tomorrowTasks.where((t) => t.isCompleted).length,
                  color: const Color(0xFF10B981),
                  icon: Icons.next_plan_rounded,
                  onTap: () {
                    // TODO: Filter tasks for tomorrow
                  },
                ),
                TaskPeriodSection(
                  title: 'This Week',
                  taskCount: weekTasks.length,
                  completedTasks: weekTasks.where((t) => t.isCompleted).length,
                  color: const Color(0xFFF59E0B),
                  icon: Icons.calendar_view_week_rounded,
                  onTap: () {
                    // TODO: Filter tasks for this week
                  },
                ),
                TaskPeriodSection(
                  title: 'All Tasks',
                  taskCount: tasks.length,
                  completedTasks: tasks.where((task) => task.isCompleted).length,
                  color: const Color(0xFF8B5CF6),
                  icon: Icons.list_alt_rounded,
                  onTap: () {
                    // TODO: Show all tasks
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}