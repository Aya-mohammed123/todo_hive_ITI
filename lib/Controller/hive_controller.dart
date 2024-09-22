import 'package:hive/hive.dart';
import '../Models/todo_model.dart';
import '../Models/todo_adaptor.dart';
import '../Models/task_adaptor.dart';

class HiveController {
  static final HiveController _instance = HiveController._internal();
  factory HiveController() {
    return _instance;
  }
  HiveController._internal();

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TodoAdaptor());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    if (Hive.isBoxOpen("todoBox")) {
      Hive.deleteBoxFromDisk("todoBox");
    }
    await Hive.openBox<TodoModel>("todoBox");
  }

  Future<Box<TodoModel>> getBox() async {
    if (!Hive.isBoxOpen("todoBox")) {
      return Hive.openBox<TodoModel>("todoBox");
    }
    return Hive.box<TodoModel>("todoBox");
  }

  Future<void> addTodoList(TodoModel todoModel) async {
    final box = await getBox();
    await box.add(todoModel);
  }

  Future<void> updateTodoGroup(int index, TodoModel updatedTodoModel) async {
    final box = await getBox();
    await box.putAt(index, updatedTodoModel);
  }

  Future<void> deleteTodoGroup(int index) async {
    final box = await getBox();
    await box.deleteAt(index);
  }

  Future<List<TodoModel>> getTodoList() async {
    final box = await getBox();
    return box.values.toList();
  }

  Future<void> clearTodoList() async {
    final box = await getBox();
    await box.clear();
  }
}
