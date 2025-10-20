import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ToDo App')),
      body: tasks.isEmpty
          ? const Center(child: Text('Not Found tasks now'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : null),
                  ),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => ref.read(taskProvider.notifier).toggleTask(task.id),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showTaskDialog(context, ref, task: task),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmation(context, ref, task),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTaskDialog(BuildContext context, WidgetRef ref, {Task? task}) {
    final textController = TextEditingController(text: task?.title ?? '');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task == null ? 'Add New Task' : 'Update task'),
          content: TextField(
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Task Title'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  if (task == null) {
                    ref.read(taskProvider.notifier).addTask(textController.text);
                  } else {
                    ref.read(taskProvider.notifier).editTask(task.id, textController.text);
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete?'),
          content: Text('Are you sure to delete this task? "${task.title}"'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
            TextButton(
              onPressed: () {
                ref.read(taskProvider.notifier).deleteTask(task.id);
                Navigator.pop(context);
                // SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(' The task was deleted successfully "${task.title}" '),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
