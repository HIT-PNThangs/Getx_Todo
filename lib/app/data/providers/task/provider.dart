import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
import '../../models/task.dart';
import '../../services/storage/services.dart';

class TaskProvider {
  StorageService storage = Get.find<StorageService>();

  List<Task> readTask() {
    var list = <Task>[];

    jsonDecode(storage.read(taskKey).toString())
        .forEach((e) => list.add(Task.fromJson(e)));

    return list;
  }

  void writeTask(List<Task> tasks) {
    storage.write(taskKey, jsonEncode(tasks));
  }
}
