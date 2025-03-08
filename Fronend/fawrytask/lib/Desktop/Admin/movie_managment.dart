import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:fawrytask/Desktop/Config/Server/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieManagment extends StatefulWidget {
  const MovieManagment({super.key});

  @override
  _MovieManagmentState createState() => _MovieManagmentState();
}

class _MovieManagmentState extends State<MovieManagment> {
  String selectedLetter = '';

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
              title: Center(child: Text('Movie Management', style: GoogleFonts.dmMono(
                fontSize: 30,
                color: CustomColors.background,
                fontWeight: FontWeight.bold,
              ))),
              backgroundColor: CustomColors.cards,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: siteParams.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Movie',
                        style: GoogleFonts.dmMono(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                       SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                       
                                    return 'Movie name cannot be empty';
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
                                    Icons.movie_rounded,
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
                                  labelText: 'Movie Name',
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
                            SizedBox(height: 10),
                          SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value?.isEmpty == true) {
                       
                                return 'Movie title cannot be empty';
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
                                Icons.title_rounded,
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
                              labelText: 'Movie Title',
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
                            controller: siteParams.movieTitleController,
                          ),
                        ),
                 const SizedBox(height: 10),
                     SizedBox(
                             width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                     
                                    return 'Movie type cannot be empty';
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
                                    Icons.generating_tokens_sharp,
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
                                  labelText: 'Movie Type',
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
                                controller: siteParams.movieTypeController,
                              ),
                            ),
                            SizedBox(height: 10),
                             SizedBox(
                         width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value?.isEmpty == true) {
                     
                                return 'Movie year cannot be empty';
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
                                Icons.calendar_month_rounded,
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
                              labelText: 'Movie Creation Year',
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
                            controller: siteParams.movieYearController,
                          ),
                        ),
                        const SizedBox(height: 10),
                     SizedBox(
                             width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                     
                                    return 'Movie poster cannot be empty';
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
                                    Icons.post_add_outlined,
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
                                  labelText: 'Movie Poster',
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
                                controller: siteParams.moviePosterController,
                              ),
                            ),
                            SizedBox(height: 10),
                             SizedBox(
                         width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value?.isEmpty == true) {
                     
                                return 'Movie imdb id cannot be empty';
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
                                Icons.lock_open_outlined,
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
                              labelText: 'IMDB ID',
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
                            controller: siteParams.movieIDController,
                          ),
                        ),
              
                      const SizedBox(height: 20),
                      Divider(color: CustomColors.cards , thickness: 5, height: 10,),
                      const SizedBox(height: 10),
                      siteParams.isLoading3? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(CustomColors.background),
                          backgroundColor: const Color.fromARGB(255, 142, 172, 108),
                        ),
                      ) :
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            backgroundColor: WidgetStateProperty.all(CustomColors.cards),
                            elevation: WidgetStateProperty.all(10),
                            textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            foregroundColor: WidgetStateProperty.all(CustomColors.background),
                            overlayColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onPressed: () async {
                            siteParams.addMovie(context);
                              bool success = await Server.addNewMovie(
                                siteParams.movieNameController.text,
                                siteParams.movieTitleController.text,
                                siteParams.movieTypeController.text,
                                siteParams.movieYearController.text,
                                siteParams.movieIDController.text,
                                siteParams.moviePosterController.text,
                                
                              );
                              if (success) {
                                siteParams.addMovie(context);
                                 ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content:  Center(child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Movie Added Successfully', style: GoogleFonts.dmMono(fontSize: 20,color: CustomColors.cards , fontWeight: FontWeight.bold),),
                                                      const SizedBox(width: 10,),
                                                      Icon(Icons.done_outlined , color: Colors.green, size: 30,)
                                                    ],
                                                  )),
                                                  
                                                ),
                                              );
                              } else {
                                siteParams.addMovie(context);
                                ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content:  Center(child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Could not Add this Movie', style: GoogleFonts.dmMono(fontSize: 20,color: CustomColors.cards , fontWeight: FontWeight.bold),),
                                                      const SizedBox(width: 10,),
                                                      Icon(Icons.dangerous_rounded , color: const Color.fromARGB(255, 255, 105, 105), size: 30,)
                                                    ],
                                                  )),
                                                  
                                                ),
                                              );
                              }
                              
                          },
                          child: Text('Add Movie'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(color: CustomColors.cards , thickness: 5, height: 10,),
                      const SizedBox(height: 10),
                      Text(
                        'Remove Movie',
                        style: GoogleFonts.dmMono(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'Movie name cannot be empty';
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
                                    Icons.title_rounded,
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
                                  labelText: 'Movie Title',
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
                                controller: siteParams.movieTitleToRemoveController,
                              ),
                            ),
                            const SizedBox(height: 10),
                      SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'Movie name cannot be empty';
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
                                  labelText: 'Movie Name',
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
                                controller: siteParams.movieNameToRemoveController,
                              ),
                            ),
                      const SizedBox(height: 20),
                        Divider(color: CustomColors.cards , thickness: 5, height: 10,),
                      const SizedBox(height: 10),
                      siteParams.isLoading2? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(CustomColors.background),
                          backgroundColor: const Color.fromARGB(255, 142, 172, 108),
                        ),
                      ) :
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              backgroundColor: WidgetStateProperty.all(CustomColors.cards),
                              elevation: WidgetStateProperty.all(10),
                              textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              foregroundColor: WidgetStateProperty.all(CustomColors.background),
                              overlayColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                            ),
                          onPressed: () async {
                            siteParams.removeMovie(context);
                              bool success = await Server.removeMovie(
                                siteParams.movieTitleToRemoveController.text, siteParams.movieNameToRemoveController.text
                              );
                              if (success) {
                                siteParams.removeMovie(context);
                                 ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content:  Center(child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Movie Removed Successfully', style: GoogleFonts.dmMono(fontSize: 20,color: CustomColors.cards , fontWeight: FontWeight.bold),),
                                                      const SizedBox(width: 10,),
                                                      Icon(Icons.done_outlined , color: Colors.green, size: 30,)
                                                    ],
                                                  )),
                                                ),
                                              );
                              } else {
                                siteParams.removeMovie(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content:  Center(child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Could not remove this Movie', style: GoogleFonts.dmMono(fontSize: 20,color: CustomColors.cards , fontWeight: FontWeight.bold),),
                                                      const SizedBox(width: 10,),
                                                      Icon(Icons.dangerous_rounded , color: const Color.fromARGB(255, 255, 105, 105), size: 30,)
                                                    ],
                                                  )),
                                                  
                                                ),
                                              );
                              }
                            
                          },
                          child: Text('Remove Movie'),
                        ),
                      ),
                      SizedBox(height: 10),
                       Divider(color: CustomColors.cards , thickness: 5, height: 10,),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, SiteStates state) {},
      ),
    );
  }
}