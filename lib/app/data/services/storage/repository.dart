import '../../models/task.dart';
import '../../providers/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTask();

  void writeTasks(List<Task> tasks) => taskProvider.writeTask(tasks);
}
