import 'package:http/http.dart' as http;
import '../constants.dart';

class MiniTaskService {
  MiniTaskService();

  Future updateMiniTaskStatus(miniTaskId) async {
    final response = await http.patch(Uri.parse('$base_url/api/miniTasks/$miniTaskId'));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}
