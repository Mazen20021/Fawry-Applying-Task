import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatelessWidget
{
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (BuildContext context) => SiteCubit(),
      child: BlocConsumer<SiteCubit, SiteStates>(
        builder: (BuildContext context, states) {
          SiteCubit siteParams = SiteCubit.get(context);
          return Scaffold(
            backgroundColor: CustomColors.background,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title:Row(children: [
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
                Center(child: Text("Welcome Back Admin",style: GoogleFonts.meaCulpa(color: CustomColors.background,fontSize: 35 , fontWeight: FontWeight.bold),)),
                 Spacer(),
                ],), 
              backgroundColor: CustomColors.cards,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    Spacer(flex: 50,),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (event) {
                        siteParams.enteredOnCurrentMoviesFunction(context);
                      },
                      onExit: (event) {
                        siteParams.enteredOnCurrentMoviesFunction(context);
                      },
                      child: GestureDetector(
                        onTap: (){Navigator.pushNamed(context, '/home/admin/currentmovies');},
                        child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color:siteParams.enteredOnCurrentMovies ? Colors.white: Colors.black,blurRadius: 10,spreadRadius: 5)],
                          color: CustomColors.cards,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             SizedBox(height: 10,),
                            Text("Current Movies",style: GoogleFonts.mysteryQuest(color:siteParams.enteredOnCurrentMovies ? Colors.white: CustomColors.background,fontSize: 30 , fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Icon(Icons.movie_filter_rounded,size: 50,color: siteParams.enteredOnCurrentMovies ? Colors.white : CustomColors.background,),
                          ],
                        )),
                                            ),
                      ),
                    ),
                    Spacer(flex: 50,),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                        onEnter: (event) {
                        siteParams.enteredOnMovieManagmentFunction(context);
                      },
                      onExit: (event) {
                        siteParams.enteredOnMovieManagmentFunction(context);
                      },
                      child: GestureDetector(
                        onTap: (){Navigator.pushNamed(context, '/home/admin/moviemanagement');},
                        child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color:siteParams.enteredMoiveManagment ? Colors.white :Colors.black,blurRadius: 10,spreadRadius: 5)],
                          color: CustomColors.cards,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10,),
                            Text("Movie Managment",style: GoogleFonts.mysteryQuest(color:siteParams.enteredMoiveManagment ? Colors.white : CustomColors.background,fontSize: 30 , fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Icon(Icons.video_settings_rounded,size: 50,color: siteParams.enteredMoiveManagment ? Colors.white : CustomColors.background,),
                          ],
                        )),),
                      ), ),
                    
                    Spacer(flex: 50,),
                  ],)
                 ]
              ),
            ),
          );
  }, listener: (BuildContext context, SiteStates state) {},));}
}