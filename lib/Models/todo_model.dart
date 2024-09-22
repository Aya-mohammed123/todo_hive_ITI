import 'task.dart';

class TodoModel {
  int id;
  String time;
  List<Task> description;

  TodoModel({
    required this.id,
    required this.time,
    required this.description,
  });
  Map<String, dynamic> tomap() => {
        'id': id,
        'time': time,
        'description': description.map((task) => task.tomap()).toList(),
      };
}
