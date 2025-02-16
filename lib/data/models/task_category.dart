import 'package:hive/hive.dart';

part 'task_category.g.dart';

@HiveType(typeId: 3)
enum TaskCategory {
  @HiveField(0)
  today,
  
  @HiveField(1)
  tomorrow,
  
  @HiveField(2)
  thisWeek;

  String get displayName {
    switch (this) {
      case TaskCategory.today:
        return 'Today';
      case TaskCategory.tomorrow:
        return 'Tomorrow';
      case TaskCategory.thisWeek:
        return 'This Week';
    }
  }
} 