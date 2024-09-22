import 'package:flutter/material.dart';
import '../Controller/hive_controller.dart';
import '../Controller/todo_controller.dart';
import '../Models/todo_model.dart';
import '../Utils/app_style.dart';
import 'add_new_task_screen.dart';
import 'task_list_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoController _todoController = TodoController();
  final HiveController _hiveController = HiveController();

  @override
  void initState() {
    super.initState();
    _loadTodoList();
  }

  Future<void> _loadTodoList() async {
    List<TodoModel> todos = await _hiveController.getTodoList();
    setState(() {
      _todoController.tasks.addAll(todos);
    });
  }

  Future<void> _clearAllTasks() async {
    await _hiveController.clearTodoList();
    setState(() {
      _todoController.tasks.clear();
    });
  }

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEE, dd MMMM yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: AppStyle.appBar,
        ),
        backgroundColor: AppStyle.primaryColor,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 200.0),
            child: Icon(Icons.today_sharp, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              "Today",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            subtitle: Text(formatDate(DateTime.now())),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red.shade400),
              onPressed: () async {
                final bool confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Delete All Tasks',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                    ),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Are you sure you want to delete all tasks?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        Text(
                          '"Note first 3 tasks will be deleted permanantly as they store in list not at box hive."',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                );

                if (confirm) {
                  await _clearAllTasks();
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoController.tasks.length,
              itemBuilder: (context, int index) {
                return TaskListScreen(
                  todoModel: TodoModel(
                    id: index,
                    time: _todoController.tasks[index].time,
                    description: _todoController.getTodoModelForIndex(index),
                  ),
                  onDelete: () {},
                  onToggleCompleted: (taskIndex, value) {
                    setState(() {});
                  },
                  onUpdate: (updatedTasks) {
                    setState(() {});
                  },
                  todoController: _todoController,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, left: 30, right: 30),
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppStyle.primaryColor),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return NewTaskButton(
                        onAdd: (newTodo) {
                          setState(() {
                            _todoController.addTodoList(newTodo);
                          });
                        },
                      );
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    Center(
                      child: Text("New Task", style: AppStyle.appBar),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
