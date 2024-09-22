import '../Controller/todo_controller.dart';

class ExpansionController {
  int id;
  String time;
  List<TodoController> description;
  ExpansionController({
    required this.id,
    required this.time,
    required this.description,
  });
}
