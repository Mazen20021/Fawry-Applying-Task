import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SiteCubit extends Cubit<SiteStates>{
  SiteCubit() : super(InitalSiteStates());

  static SiteCubit get(BuildContext context) => BlocProvider.of(context);
  GlobalKey key = GlobalKey();
  int currentIndex = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEmpty = true;
  bool isChecked = false;
  bool enteredOnLogin = false;
  bool enteredOnSignup = false;

  void checkTextFields(BuildContext context){
    if(!isChecked){
      isChecked = true;
      isEmpty = !isEmpty;
      emit(IsEmptyChecker());
      }
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