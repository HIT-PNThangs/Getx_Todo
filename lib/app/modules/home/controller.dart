import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/data/models/task.dart';
import 'package:getx_todo/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
    editController.dispose();
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeTask(Task? selectTask) {
    task.value = selectTask;
  }

  void changeTodos(List<dynamic> selected) {
    doingTodos.clear();
    doneTodos.clear();

    for (int i = 0; i < selected.length; i++) {
      var todo = selected[i];

      if (todo['done'] == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }

    tasks.add(task);
    return true;
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containerTodo(todos, title)) {
      return false;
    }

    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task);

    tasks[oldIndex] = newTask;
    tasks.refresh();

    return true;
  }

  bool containerTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};

    if (doingTodos.any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }

    var doneTodo = {'title': title, 'done': true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }

    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);

    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    var item = {'title': title, 'done': true};

    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));

    doingTodos.removeAt(index);
    doneTodos.add(item);

    doneTodos.refresh();
    doingTodos.refresh();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos.indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));

    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task) {
    return task.todos!.isEmpty || task.todos == null;
  }

  int getDoneTodo(Task task) {
    var res = 0;

    for(int i = 0; i < task.todos!.length; i++) {
      if(task.todos![i]['done'] == true) {
        res += 1;
      }
    }

    return res;
  }
}
