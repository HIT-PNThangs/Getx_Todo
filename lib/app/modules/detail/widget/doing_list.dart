import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/note_widget.dart';
import '../../home/controller.dart';
import '../../../core/utils/extensions.dart';

class DoingList extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doingTodos.isEmpty &&
            homeController.doneTodos.isEmpty
        ? Column(
            children: [
              const NoteWidget(),
              Text(
                "Add Task",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeController.doingTodos
                  .map((element) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 9.0.wp),
                    child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                                value: element['done'],
                                onChanged: (value) {
                                  homeController.doneTodo(element['title']);
                                },
                              ),
                            ),
                            SizedBox(width: 3.0.wp,),
                            Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                  ))
                  .toList(),

              if(homeController.doingTodos.isNotEmpty) Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: const Divider(thickness: 2),
              )
            ],
          ));
  }
}
