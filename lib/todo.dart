import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/custom_print.dart';
import 'package:untitled/entities/task_modal.dart';

import 'controller/controller.dart';

///Old Code
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Todo List',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<TaskController>(
          builder: (context, controller, child) {
            return widgetTaskList();
          },
        ),
        floatingActionButton: addTaskButton());
  }

  Widget addTaskButton() {
    final controller = Provider.of<TaskController>(context);
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Add Task"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            controller.taskController.text = value;
                          });
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Type your Task here..."),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (controller.taskController.text.isEmpty ||
                                controller.taskController == "") return;
                            controller.dbHelper.addTask(
                                controller.taskController.text.toString());
                            setState(() {
                              controller.taskController.text.isEmpty;
                            });
                            controller.taskController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Done"))
                    ],
                  ),
                ));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget widgetTaskList() {
    final controller = Provider.of<TaskController>(context);
    return FutureBuilder<List<TaskModal>>(
      future: controller.dbHelper.getTask(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          Center(
            child: Text("${snapshot.hasError}!"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks found.'));
        }
        List<TaskModal>? tasks = snapshot.data;
        customPrint("Snapshot data ${snapshot.data}");
        bool isAnyTaskChecked = tasks!.any((task) => task.status == 1);
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  TaskModal taskModal = snapshot.data![index];
                  return ListTile(
                    onLongPress: () {
                      controller.dbHelper.deleteTask(taskModal.iD);
                      setState(() {});
                    },
                    title: Text(taskModal.content),
                    trailing: Checkbox(
                      value: taskModal.status == 1,
                      onChanged: (value) {
                        controller.updateTaskStatus(
                            taskModal.iD, value == true ? 1 : 0);
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
            if (isAnyTaskChecked) buildAssignTaskButton(context, tasks),
          ],
        );
      },
    );
  }

  Widget buildAssignTaskButton(BuildContext context, List<TaskModal>? tasks) {
    final controller = Provider.of<TaskController>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(h * 0.02),
      child: SizedBox(
        width: w * 0.5,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () {
            bool isAlreadyExists = false;

            tasks!.where((task) => task.status == 1).forEach((task) {
              if (!controller.pendingTasksList
                  .any((pendingTask) => pendingTask.iD == task.iD)) {
                controller.assignTask(task.iD);
              } else {
                isAlreadyExists = true; // Set flag if task is already assigned
              }
            });

            if (isAlreadyExists) {
              // Show message that tasks are already assigned
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Already Assigned"),
                  content: const Text("Some tasks are already assigned."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), // Close dialog
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text(
            "Assign Task",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
