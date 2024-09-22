import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../Controller/hive_controller.dart';
import '../Controller/todo_controller.dart';
import '../Models/task.dart';
import '../Models/todo_model.dart';
import '../Utils/app_style.dart';

class NewTaskButton extends StatefulWidget {
  final Function(TodoModel) onAdd;

  const NewTaskButton({
    super.key,
    required this.onAdd,
  });

  @override
  State<NewTaskButton> createState() => _NewTaskButtonState();
}

class _NewTaskButtonState extends State<NewTaskButton> {
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TodoController _todoController = TodoController();
  final List<Task> _taskList = [];
  final HiveController _hiveController = HiveController();
  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensure screen resizes to avoid the keyboard
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            Center(
              child: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.do_disturb,
                    color: Colors.transparent,
                  ),
                  onPressed: () {},
                ),
                title: const Padding(
                  padding: EdgeInsets.all(60.0),
                  child: Text('Add Task'),
                ),
                elevation: 4,
                backgroundColor: AppStyle.primaryColor,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Time:     ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppStyle.primaryColor, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TimePickerSpinner(
                        time: _selectedTime,
                        is24HourMode: false,
                        normalTextStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        highlightedTextStyle: const TextStyle(
                          fontSize: 24,
                          color: AppStyle.primaryColor,
                        ),
                        spacing: 50,
                        itemHeight: 40,
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          setState(() {
                            _selectedTime = time;
                            _timeController.text =
                                DateFormat('hh:mm a').format(_selectedTime);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Description: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_descriptionController.text.isNotEmpty) {
                  setState(() {
                    _taskList.add(Task(
                      name: _descriptionController.text,
                      isCompleted: false,
                    ));
                    _descriptionController.clear();
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppStyle.primaryColor),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_taskList[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _taskList.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 60, right: 60),
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppStyle.primaryColor),
                  ),
                  onPressed: () async {
                    if (_taskList.isNotEmpty &&
                        _timeController.text.isNotEmpty) {
                      TodoModel newList = TodoModel(
                        id: _todoController.tasks.length + 1,
                        time: _timeController.text,
                        description: _taskList,
                      );
                      await _hiveController.addTodoList(newList);
                      widget.onAdd(newList);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Center(
                        child: Text(
                          "Confirm",
                          style: AppStyle.appBar,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
