import 'dart:math';

import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SiteCubit extends Cubit<SiteStates>{
  SiteCubit() : super(InitalSiteStates());

  static SiteCubit get(BuildContext context) => BlocProvider.of(context);
  GlobalKey<FormState> key = GlobalKey();
  int currentIndex = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController movieTitleController = TextEditingController();
  final TextEditingController movieTypeController = TextEditingController();
  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController movieYearController = TextEditingController();
  final TextEditingController moviePosterController = TextEditingController();
  final TextEditingController movieIDController = TextEditingController();
  final TextEditingController movieTitleToRemoveController = TextEditingController();
  final TextEditingController movieNameToRemoveController = TextEditingController();


  bool isEmpty = true;
  bool isChecked = false;
  bool enteredOnLogin = false;
  bool enteredOnSignup = false;
  bool isLoading = false;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool isPressed = false;
  bool enteredOnLogout = false;
  bool enteredOnCurrentMovies = false;
  bool enteredMoiveManagment = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  String movieName = "";

  void setName(String name){
    movieName = name;
    emit(SetName());
  }
  void removeMovie(BuildContext context){
    isLoading2 = !isLoading2;
    emit(RemoveMovies());
  }
  void addMovie(BuildContext context){
    isLoading3 = !isLoading3;
    emit(AddMovies());
  }
  void enteredOnCurrentMoviesFunction (BuildContext context){
    enteredOnCurrentMovies = !enteredOnCurrentMovies;
    emit(EnteredOnCurrentMovies());
  }
  void enteredOnMovieManagmentFunction (BuildContext context){
    enteredMoiveManagment = !enteredMoiveManagment;
    emit(EnteredOnMovieManagment());
  }
void logout(BuildContext context)
{
  enteredOnLogout = !enteredOnLogout;
  emit(Logout());
}
void checkIfPressed(BuildContext context){
    isPressed = !isPressed;
    emit(IsPressed());
  }
  void checkUser(BuildContext context){
    isLoading = !isLoading;
    emit(IsLoading());
  }
    void hidePassword(BuildContext context){
    isPasswordHidden = !isPasswordHidden;
    emit(HidePassword());
  }
   void hideConfirmPassword(BuildContext context){
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    emit(HideConfirmPassword());
  }
  void checkTextFields(BuildContext context){
      emit(IsEmptyChecker());
  }
  void enteredOnLoginButton(BuildContext context){
      enteredOnLogin = !enteredOnLogin;
      emit(IsEnteredOnLogin());
    
  }
 void enteredOnSignupButton(BuildContext context){
      enteredOnSignup = !enteredOnSignup;
      emit(IsEnteredOnSignup());
    
  }
}