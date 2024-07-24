import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/custom_print.dart';
import 'package:untitled/entities/task_modal.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();
  static Database? db;

  DatabaseHelper.internal();

  final String tableName = "tableName";
  final String taskTableID = "id";
  final String taskTableName = "content";
  final String taskTableStatus = "status";

  Future<Database> get dataBase async {
    if (db != null) return db!;
    db = await getDatabase();
    return db!;
  }

  Future<Database> getDatabase() async {
    final directPath = await getDatabasesPath();
    final path = join(directPath, "my_sample.db");
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE $tableName($taskTableID  INTEGER PRIMARY KEY,
      $taskTableName TEXT NOT NULL,
      $taskTableStatus INTEGER  NOT NULL
      )
      ''');
      },
    );
    return database;
  }

  addTask(
    String content,
  ) async {
    final db = await dataBase;
    await db.insert(tableName, {
      taskTableName: content,
      taskTableStatus: 0,
    });
  }

  Future<List<TaskModal>> getTask() async {
    final db = await dataBase;
    final data = await db.query(tableName);
    List<TaskModal> tasks = data
        .map(
          (e) => TaskModal(
              iD: e["id"] as int,
              status: e["status"] as int,
              content: e["content"] as String),
        )
        .toList();
    customPrint("Get task Service data $tasks");
    return tasks;
  }

  updateStatus(int id, int status) async {
    final db = await dataBase;
    await db.update(tableName, {taskTableStatus: status},
        where: "id = ?",
        whereArgs: [
          id,
        ]);
  }

  Future<List<TaskModal>> getPendingTasks() async {
    try {
      final db = await dataBase;
      final data = await db
          .query(tableName, where: "$taskTableStatus = ?", whereArgs: [2]);
      List<TaskModal> assgintasks = data
          .map(
            (e) => TaskModal(
                iD: e["id"] as int,
                status: e["status"] as int,
                content: e["content"] as String),
          )
          .toList();
      customPrint(
          "getPendingTasks: Retrieved ${assgintasks.length} pending tasks");
      return assgintasks;
    } catch (e) {
      customPrint("Error fetching pending tasks: $e");
      return [];
    }
  }

  deleteTask(int id) async {
    final db = await dataBase;
    await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
