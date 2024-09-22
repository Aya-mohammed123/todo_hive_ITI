import 'package:flutter/material.dart';
import '../Controller/todo_controller.dart';
import '../Models/todo_model.dart';
import '../Models/task.dart';
import '../Widget/task_list_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({
    super.key,
    required this.todoModel,
    required this.onDelete,
    required this.onToggleCompleted,
    required this.onUpdate,
    required this.todoController,
  });

  final TodoModel todoModel;
  final VoidCallback onDelete;
  final Function(int, bool) onToggleCompleted;
  final Function(List<Task>) onUpdate;
  final TodoController todoController;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late List<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = List.generate(1, (index) => false);
  }

  void _toggleTask(int taskIndex, bool? value) {
    setState(() {
      widget.todoModel.description[taskIndex].isCompleted = value ?? false;
      widget.onToggleCompleted(taskIndex, value ?? false);
    });
  }

  void _editTask(int taskIndex) {}

  void _deleteTask(int taskIndex) {
    setState(() {
      widget.todoModel.description.removeAt(taskIndex);
      widget.onUpdate(widget.todoModel.description);
    });
  }

  int _countCompletedTasks(List<Task> taskList) {
    return taskList.where((task) => task.isCompleted).length;
  }

  bool _areAllTasksCompleted(List<Task> taskList) {
    return taskList.every((task) => task.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionPanelList(
            expandIconColor: Colors.transparent,
            expandedHeaderPadding: const EdgeInsets.all(8),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded[index] = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: Colors.grey[200],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.todoModel.time,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_countCompletedTasks(widget.todoModel.description)}/${widget.todoModel.description.length} tasks',
                          style: TextStyle(
                            color: _areAllTasksCompleted(
                                    widget.todoModel.description)
                                ? Colors.cyan[700]
                                : Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded[0] = !isExpanded;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
                body: Column(
                  children: [
                    TaskListWidget(
                      tasks: widget.todoModel.description,
                      onTaskToggle: (index, value) => _toggleTask(index, value),
                      onEditTask: (index) => _editTask(index),
                      onDeleteTask: (index) => _deleteTask(index),
                    ),
                  ],
                ),
                isExpanded: _isExpanded[0],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
