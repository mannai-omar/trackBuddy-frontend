import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Task.dart';

class TaskService {
  TaskService();

  Future<List<Tasks>> fetchTasks() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/tasks'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(response.body);
      return data.map((task) => Tasks.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
