import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Task.dart';
import '../constants.dart';

class TaskService {
  TaskService();

  Future<List<Tasks>> fetchTasks() async {
    final response = await http.get(Uri.parse('$base_url/api/tasks'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      //print(response.body);
      return data.map((task) => Tasks.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> addTask(Tasks task) async {
    final response = await http.post(
      Uri.parse('$base_url/api/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add task. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }
}
