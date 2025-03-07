import 'package:fawrytask/Desktop/Config/Server/Config/server_config.dart';
import 'package:http/http.dart' as http;

class Server {

  static Future<String> login(String email, String password) async {
  
    try {
      var url = Uri.http(ServerConfig.serverUrl, "/auth", {"email": email, "password": password});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if(response.body == 1.toString())
        {
            return "Admin";
        }else if(response.body == 0.toString()){
            return "User";
        }else{
          return "";
        }
      } else {
        print("Didn't Connect to server: ${response.statusCode}");
        print("Response body: ${response.body}");
         return "Error";
      }
    } catch (e) {
      print("Didn't Connect to server: $e");
      return "Error";
    }
  }
  static Future<bool> signup(String email, String password , String name) async {
      try {
      var url = Uri.http(ServerConfig.serverUrl, "/signup", {"email": email, "password": password , "name": name});
      final response = await http.get(url);
      if (response.statusCode == 200) {
       return true;
      } else {
        print("Didn't Connect to server: ${response.statusCode}");
        print("Response body: ${response.body}");
         return false;
      }
    } catch (e) {
      print("Didn't Connect to server: $e");
      return false;
    }
  }
}