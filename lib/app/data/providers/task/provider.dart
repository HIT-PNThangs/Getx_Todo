import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/keys.dart';
import 'package:getx_todo/app/data/models/task.dart';
import 'package:getx_todo/app/data/services/storage/services.dart';

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
