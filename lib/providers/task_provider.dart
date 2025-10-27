import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

const String tasksBoxName = "tasks";

class TaskNotifier extends Notifier<List<Task>> {
  final Box<Task> _box;
  TaskNotifier(this._box);

  @override
  List<Task> build() {
    return _box.values.toList();
  }

  void _loadTasks() {
    state = _box.values.toList();
  }

  void addTask(String title) {
    final taskId = DateTime.now().toIso8601String();
    final newTask = Task(id: taskId, title: title);
    _box.put(taskId, newTask);
    _loadTasks();
  }

  void toggleTask(String taskId) {
    final task = _box.get(taskId);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      task.save();
      _loadTasks();
    }
  }

  void editTask(String taskId, String newTitle) {
    final task = _box.get(taskId);
    if (task != null) {
      task.title = newTitle;
      task.save();
      _loadTasks();
    }
  }

  void deleteTask(String taskId) {
    _box.delete(taskId);
    _loadTasks();
  }
}

final taskProvider = NotifierProvider<TaskNotifier, List<Task>>(() {
  final box = Hive.box<Task>(tasksBoxName);
  return TaskNotifier(box);
});
