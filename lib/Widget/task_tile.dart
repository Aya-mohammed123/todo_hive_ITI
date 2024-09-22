// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../Models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final Function(bool?)? onChanged;
  final VoidCallback onDelete;
  const TaskTile({
    super.key,
    required this.task,
    this.onChanged,
    required this.onDelete,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  void _showEditTodoDialog(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.task.name);

    bool isCompleted = widget.task.isCompleted;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[200],
        title: const Text("Edit Task"),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Task Name"),
                  controller: nameController,
                ),
                CheckboxListTile(
                  title: const Text("Completed"),
                  value: isCompleted,
                  onChanged: (newValue) {
                    setState(() {
                      isCompleted = newValue ?? false;
                    });
                  },
                  activeColor: Colors.blueGrey,
                  checkColor: Colors.white,
                ),
              ],
            );
          },
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blueGrey),
            ),
            onPressed: () {
              setState(() {
                widget.task.name = nameController.text;
                widget.task.isCompleted = isCompleted;
              });
              Navigator.pop(context);
            },
            child: const Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.task.isCompleted,
          onChanged: widget.onChanged,
          activeColor: Colors.blueGrey,
          checkColor: Colors.white,
        ),
        Expanded(
          child: Text(
            widget.task.name,
            style: TextStyle(
              decoration:
                  widget.task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _showEditTodoDialog(context);
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: widget.onDelete,
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
