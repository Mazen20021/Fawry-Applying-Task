import 'package:fawrytask/Desktop/Common_Pages/movie_details.dart';
import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:fawrytask/Desktop/Config/DTOs/movie_dto.dart';
import 'package:fawrytask/Desktop/Config/Server/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => SiteCubit(),
      child: BlocConsumer<SiteCubit, SiteStates>(
        builder: (BuildContext context, states) {
          SiteCubit siteParams = SiteCubit.get(context);
          
          if(!siteParams.fetchMovies)
          {
            siteParams.searchForMovie("All");
            siteParams.fetchAllMovie();
          }
          return Scaffold(
            backgroundColor: CustomColors.background,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Row(children: [
                SizedBox(width: 10,),
                MouseRegion(
                  onEnter: (event) {
                    siteParams.logout(context);
                  },
                  onExit: (event) {
                    siteParams.logout(context);
                  },
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                onTap: (){Navigator.pushNamed(context, '/login');},
                child:Icon(Icons.logout_outlined , size: 30,color: siteParams.enteredOnLogout?  Colors.white : CustomColors.background,),)),
                Spacer(),
                Center(child: Text("Welcome Back",style: GoogleFonts.meaCulpa(color: CustomColors.background,fontSize: 35 , fontWeight: FontWeight.bold),)),
                 Spacer(),
                ],), 
              ),
              backgroundColor: CustomColors.cards,
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'Movie Search cannot be empty';
                                  }
                                  return null;
                                },
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  errorStyle: GoogleFonts.aBeeZee(
                                    fontSize: 15,
                                    color: const Color.fromARGB(255, 247, 108, 98),
                                  ),
                                  fillColor: CustomColors.background,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: siteParams.isEmpty
                                          ? CustomColors.cards
                                          : Colors.red,
                                    ),
                                  ),
                                  hoverColor: CustomColors.background,
                                  prefixIcon: const Icon(
                                    Icons.movie_creation_rounded,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: siteParams.isEmpty
                                          ? CustomColors.cards
                                          : Colors.red,
                                    ),
                                  ),
                                  labelText: 'Search for a movie by name',
                                  labelStyle: TextStyle(
                                    color: siteParams.isEmpty
                                        ? Colors.white
                                        : Colors.red,
                                  ),
                                  hintStyle: TextStyle(
                                    color: siteParams.isEmpty
                                        ? Colors.white
                                        : Colors.red,
                                  ),
                                ),
                                controller: siteParams.movieNameController,
                              ),
                            ),
                            SizedBox(width: 5,),
                             ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            backgroundColor: WidgetStateProperty.all(CustomColors.cards),
                            elevation: WidgetStateProperty.all(10),
                            textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            foregroundColor: WidgetStateProperty.all(CustomColors.background),
                            overlayColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onPressed: () async {
                             siteParams.searchForMovie(siteParams.movieNameController.text);
                             if(siteParams.movieNameController.text.isEmpty)
                             {
                              siteParams.searchForMovie("All");
                             }
                          },
                          child: Text('Search'),
                        ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
  child: BlocBuilder<SiteCubit, SiteStates>(
    builder: (context, state) {
      if (state is LoadingMoviesState) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.background),
            backgroundColor: const Color.fromARGB(255, 142, 172, 108),
          ),
        );
      } else if (state is ErrorMoviesState) {
        return Center(child: Text('Failed to load movies'));
      } else if (siteParams.movies.isEmpty) {
        return Center(child: Text('No movies available'));
      } else {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemCount: siteParams.movies.length,
          itemBuilder: (context, index) {
            var movie = siteParams.movies[index];
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetails(
                        title: movie.title,
                        poster: movie.poster,
                        type: movie.type,
                        year: movie.year,
                        imdbID: movie.imdbID,
                      ),
                    ),
                  );
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
                        child: Image.network(
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
),

              ],
            ),
          );
        },
        listener: (BuildContext context, SiteStates state) {},
      ),
    );
  }
}