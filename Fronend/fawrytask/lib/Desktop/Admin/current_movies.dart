import 'package:fawrytask/Desktop/Common_Pages/movie_details.dart';
import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:fawrytask/Desktop/Config/DTOs/movie_dto.dart';
import 'package:fawrytask/Desktop/Config/Server/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentMovies extends StatefulWidget {
  @override
  _CurrentMoviesState createState() => _CurrentMoviesState();
}

class _CurrentMoviesState extends State<CurrentMovies>{

  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => SiteCubit(),
      child: BlocConsumer<SiteCubit, SiteStates>(
        builder: (BuildContext context, states) {
          SiteCubit siteParams = SiteCubit.get(context);
          return Scaffold(
            backgroundColor: CustomColors.background,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: Text('Current Movies', style: GoogleFonts.dmMono(
                fontSize: 30,
                color: CustomColors.background,
                fontWeight: FontWeight.bold,
              ))),
              backgroundColor: CustomColors.cards,
            ),
            body: SingleChildScrollView(
              child: FutureBuilder<List<MovieDTO>>(
                future: Server.getAllMovies(), // Ensure this returns a List<movies_dto>
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(CustomColors.background),
                        backgroundColor: const Color.fromARGB(255, 142, 172, 108),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load movies'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No movies available'));
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling issues
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 2 movies per row
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6, // Adjust for movie posters
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var movie = snapshot.data![index];
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(
                                title: movie.title,
                                poster: movie.poster,
                                type: movie.type,
                                year: movie.year,
                                imdbID: movie.imdbID,
                              ))); 
                            },
                            child: Card(
                                          color: Colors.black87,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                                child: 
                                                Image.network(
                                                  movie.poster,
                                                  height: 650,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    height: 650,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    child: Icon(Icons.image_not_supported, color: Colors.white),
                                                  );
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(
                                                  movie.title,
                                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                movie.type.toUpperCase(),
                                                style: TextStyle(color: Colors.grey, fontSize: 14),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                movie.year,
                                                style: TextStyle(color: Colors.orangeAccent, fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ));

          }, listener: (BuildContext context, SiteStates state) {  },));
}
}