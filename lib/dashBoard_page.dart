import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/scaffold_message.dart';
import 'package:untitled/second_page.dart';
import 'package:untitled/todo.dart';
import 'package:upgrader/upgrader.dart';

import 'controller/controller.dart';
import 'custom_print.dart';
import 'entities/task_modal.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    //
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    if (Platform.isAndroid) {
      setState(() {
        _isUpdating = true;
      });
      try {
        final info = await InAppUpdate.checkForUpdate();
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          await InAppUpdate.performImmediateUpdate();
        }
      } catch (e) {
        customPrint("Update check failed: $e");
      } finally {
        setState(() {
          _isUpdating = false;
        });
      }
    } else if (Platform.isIOS) {
      UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
      );
    } else {
      customSnackBar(context, "NO Updates");
    }
  }

  final DateTime date = DateTime.now();
  final DateFormat dateFormat = DateFormat('dd-MMM-yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context);
    return UpgradeAlert(
      showLater: false,
      showIgnore: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: const Text(
            'UPGRADE PACKAGE CHECK',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_isUpdating) const LinearProgressIndicator(),
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text("User : ",
                            style: TextStyle(color: Colors.white)),
                        const Text("Shinas John ",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(width: 50),
                        Text(
                          dateFormat.format(date), // Display formatted date
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    const Text("Company Name : ABC",
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/images/pendingLoan.png"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.abc,
              size: 90,
            ),
            const SizedBox(height: 10),
            const Text(
              "Hello Mr. Shinas John",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Get.to(TodoList());
                  },
                  child: const Text(
                    "Todo Page",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Get.to(SecondPage());
                  },
                  child: const Text(
                    "Site Page",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const Text("IN-App Upgrade"),
            Consumer<TaskController>(
              builder: (context, value, child) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.blueGrey.shade100,
                      child: widgetPendingTasks(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget widgetPendingTasks() {
    return Consumer<TaskController>(
      builder: (context, controller, child) {
        return ListView.builder(
          itemCount: controller.pendingTasksList.length,
          itemBuilder: (context, index) {
            TaskModal task = controller.pendingTasksList[index];
            return ListTile(
              onLongPress: () {
                controller.deleteTask(task.iD);
                setState(() {});
              },
              title: Text(task.content),
              // You can add more UI elements or functionality for pending tasks here
            );
          },
        );
      },
    );
  }
}
