import 'package:flutter/material.dart';
import '../Models/task.dart';

import 'task_tile.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;
  final Function(int, bool?) onTaskToggle;
  final Function(int) onEditTask;
  final Function(int) onDeleteTask;
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap:
          true, // Ensure the ListView fits inside the ExpansionPanel body to handle harsize error
      physics:
          const NeverScrollableScrollPhysics(), // Prevent scrolling conflict
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(
          task: task,
          onChanged: (value) => onTaskToggle(index, value),
          onDelete: () => onDeleteTask(index),
        );
      },
    );
  }
}
