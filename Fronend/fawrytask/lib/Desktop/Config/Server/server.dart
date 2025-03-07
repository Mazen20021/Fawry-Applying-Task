import 'package:fawrytask/Desktop/Config/Server/Config/server_config.dart';
import 'package:http/http.dart' as http;

class Server {

  static Future<void> connect(String email, String password) async {
  var url = Uri.parse("http://localhost:8080/auth?email=$email&password=$password");

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Connected to server");
    } else {
      print("Didn't Connect to server");
    }
  } catch (e) {
    print("Didn't Connect to server: $e");
  }
}


}