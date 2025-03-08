import 'dart:convert';

import 'package:fawrytask/Desktop/Config/DTOs/movie_dto.dart';
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
  static Future<bool> addNewMovie(String movieName, String movieTitle , String movieType , String movieYear , String id , String poster) async {
      try {
      var url = Uri.http(ServerConfig.serverUrl, "/admin/add", {"title": movieTitle, "type": movieType , "movieName": movieName , "year": movieYear , "imdbID" : id , "poster" : poster});
      final response = await http.put(url);
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
  static Future<bool> removeMovie(String movieName , String title) async {
      try {
      var url = Uri.http(ServerConfig.serverUrl, "/admin/remove", {"name": movieName , "title" : title });
      final response = await http.delete(url);
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
  static Future<List<String>> getAllNamesMovies() async {
    var url = Uri.http(ServerConfig.serverUrl, "/home/movies" );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> moviesJson = json.decode(response.body);
      List<String> movies = moviesJson.map((movie) => movie["title"].toString()).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

static Future<List<MovieDTO>> getAllMovies() async {
  var url = Uri.http(ServerConfig.serverUrl, "/home/movies");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> moviesJson = json.decode(response.body);
    
    List<MovieDTO> movies = moviesJson.map((movie) => MovieDTO.fromJson(movie)).toList();
    
    return movies;
  } else {
    throw Exception('Failed to load movies');
  }
}
static Future<List<MovieDTO>> searchForMovie(String name) async {
  var url = Uri.http(ServerConfig.serverUrl, "/home/search", {"movieName": name});
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> moviesJson = json.decode(response.body);
    
    List<MovieDTO> movies = moviesJson.map((movie) => MovieDTO.fromJson(movie)).toList();
    
    return movies;
  } else {
    throw Exception('Failed to load movies');
  }
}

}