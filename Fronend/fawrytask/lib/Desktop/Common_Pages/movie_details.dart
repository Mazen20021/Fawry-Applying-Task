import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetails extends StatelessWidget {
  final String title;
  final String poster;
  final String type;
  final String year;
  final String imdbID;
 
  const MovieDetails({
    super.key,
    required this.title,
    required this.poster,
    required this.type,
    required this.year,
    required this.imdbID,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(title , style: GoogleFonts.mPlus1(color: Colors.white),),
              Spacer(),
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.cancel , color: Colors.red, size: 45,))
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.background,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                poster,
                height: 500,
                width: 350,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    width: 200,
                    color: Colors.grey[800],
                    child: const Icon(Icons.image_not_supported, size: 50, color: Colors.white),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Type: $type",
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              "Year: $year",
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              "IMDB ID: $imdbID",
              style: const TextStyle(fontSize: 16, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
