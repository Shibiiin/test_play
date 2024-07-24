import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/custom_print.dart';
import 'package:untitled/entities/task_modal.dart';

import '../entities/assigned_modal.dart';
import '../entities/service.dart';

class TaskController extends ChangeNotifier {
  TaskController() {
    // fetchTasks();
  }

  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final taskController = TextEditingController();
  final isChecked = false;

  ///task list
  List<TaskModal> tasksList = [];
  // List<TaskModal> get taskList => tasks;

  ///pending task
  List<TaskModal> pendingTasksList = [];
  // List<TaskModal> get pendingTaskList => pendingTasks;

  Future<List<TaskModal>> fetchTasks() async {
    customPrint("Task List ${tasksList.length}");
    customPrint("Pending List ${pendingTasksList.length}");
    try {
      tasksList = await dbHelper.getTask();
      notifyListeners();
      return tasksList;
    } catch (e) {
      customPrint("Error fetching tasks: $e");
      throw e; // Re-throw the error to propagate it further if needed
    }
  }

  // Future<List<TaskModal>> fetchTasks() async {
  //   try {
  //     final tasks = await dbHelper.getTask();
  //     customPrint("Fetch Task Data $tasks");
  //     return tasks;
  //   } catch (e) {
  //     // customSnackBar(context, "$e");
  //   }
  //   return tasks;
  // }

  Future<void> fetchPendingTasks() async {
    try {
      pendingTasksList = await dbHelper.getPendingTasks();
      notifyListeners();
    } catch (e) {
      customPrint("Fetch Pending Task ERROR $e");
    }
  }

  Future addTask(String content, context) async {
    await dbHelper.addTask(content);
    fetchTasks();
  }

  Future<void> updateTaskStatus(int id, int status) async {
    try {
      await dbHelper.updateStatus(id, status);
      await fetchTasks();

      if (status == 1) {
        TaskModal task = tasksList.firstWhere((task) => task.iD == id);
        tasksList.remove(task);
        notifyListeners();

        AssignedModal assignedTask = AssignedModal(
          iD: task.iD,
          status: task.status,
          content: task.content,
          subContent: 'Some additional info',
        );
        pendingTasksList.add(assignedTask);
        notifyListeners();
      }

      await fetchPendingTasks();
    } catch (e) {
      customPrint("Error updating task status: $e");
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await dbHelper.deleteTask(id);
      await fetchPendingTasks();
    } catch (e) {
      customPrint("Error deleting task: $e");
    }
  }

  Future toggleTaskStatus(int id, int status, bool isChecked, context) async {
    isChecked = true;
    await dbHelper.updateStatus(id, status);
    fetchTasks();
  }

  Future<void> assignTask(int id) async {
    try {
      await dbHelper.updateStatus(id, 2);
      await fetchTasks();
      notifyListeners();
      await fetchPendingTasks();
      notifyListeners();
    } catch (e) {
      customPrint("Error assigning task: $e");
    }
  }
}
