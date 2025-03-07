import 'package:fawrytask/Desktop/Config/Server/Config/server_config.dart';
import 'package:http/http.dart' as http;

class Server {


  static Future<void> connect() async {
    String responseText = "";
    try{
      final response = await http.get(Uri.parse("${ServerConfig.serverUrl}/test"));
    if (response.statusCode == 200) {

        responseText = response.body;
        print(responseText);
    } else {
      
        responseText = "Error: ${response.statusCode}";
        print(responseText);
    }
    }catch(e){
      print("DueTo: "+responseText + e.toString());
    }
    
  }

}