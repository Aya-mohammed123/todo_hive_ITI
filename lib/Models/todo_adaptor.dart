import 'task.dart';
import 'todo_model.dart';
import 'package:hive/hive.dart';

class TodoAdaptor extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 2;

  @override
  TodoModel read(BinaryReader reader) {
    return TodoModel(
      id: reader.readInt(),
      time: reader.readString(),
      description: (reader.readList()).cast<Task>(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.time);
    writer.writeList(obj.description);
  }
}
