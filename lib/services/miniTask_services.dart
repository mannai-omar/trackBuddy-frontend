import 'dart:convert';
import 'package:http/http.dart' as http;

class MiniTaskService {
  MiniTaskService();

  Future updateMiniTaskStatus(miniTaskId) async {
    final response = await http.patch(Uri.parse('http://localhost:3000/api/miniTasks/' + miniTaskId));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}
