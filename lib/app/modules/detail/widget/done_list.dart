import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/extensions.dart';
import '../../home/controller.dart';


class DoneList extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                child: Text(
                  'Completed(${homeController.doneTodos.length})',
                  style: TextStyle(fontSize: 14.0.sp),
                ),
              ),
              ...homeController.doneTodos
                  .map((element) => Dismissible(
                    key: ObjectKey(element),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => homeController.deleteDoneTodo(element),
                    background: Container(
                      color: Colors.red.withOpacity(0.8),
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0.wp),
                        child: const Icon(Icons.delete, color: Colors.white,),
                      ),
                    ),
                    child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 9.0.wp, vertical: 3.0.wp),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(Icons.done, color: Colors.blue),
                              ),
                              SizedBox(
                                width: 3.0.wp,
                              ),
                              Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          ),
                        ),
                  ))
                  .toList(),
            ],
          )
        : Container());
  }
}
