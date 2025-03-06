import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget
{
  const Login({super.key});
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(create: (BuildContext context) => SiteCubit(), 
    child: BlocConsumer<SiteCubit , SiteStates>(builder: (BuildContext context , states){
      SiteCubit siteParams = SiteCubit.get(context);
    return Form(
      key: siteParams.key,
      child: Scaffold(
      backgroundColor: CustomColors.background,
      body: 
          Center(
            child: Container(
              width: 600,
              height: 500,
              decoration: BoxDecoration(
                color: CustomColors.cards.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text('Welcome', style: TextStyle(fontSize: 20, color: Colors.white),),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 550,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration:  InputDecoration(
                        fillColor: CustomColors.background,
                        filled: true,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: siteParams.isEmpty&& siteParams.emailController.text.isEmpty? CustomColors.background : Colors.red)),
                        hoverColor: CustomColors.background,
                        prefixIcon: const Icon(Icons.email, color: Colors.white,),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: siteParams.isEmpty&& siteParams.emailController.text.isEmpty ? CustomColors.cards : Colors.red)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: siteParams.isEmpty && siteParams.emailController.text.isEmpty  ? Colors.white : Colors.red),
                        hintStyle: TextStyle(color: siteParams.isEmpty && siteParams.emailController.text.isEmpty ? Colors.white : Colors.red),
                      ),
                      controller: siteParams.emailController,
                    ),
                  ),
                   const SizedBox(height: 20,),
                  SizedBox(
                    width: 550,
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration:  InputDecoration(
                        fillColor: CustomColors.background,
                        filled: true,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: siteParams.isEmpty&& siteParams.passwordController.text.isEmpty? CustomColors.background : Colors.red)),
                        hoverColor: CustomColors.background,
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.white,),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: siteParams.isEmpty&& siteParams.passwordController.text.isEmpty ? CustomColors.cards : Colors.red)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: siteParams.isEmpty && siteParams.passwordController.text.isEmpty  ? Colors.white : Colors.red),
                        hintStyle: TextStyle(color: siteParams.isEmpty && siteParams.passwordController.text.isEmpty ? Colors.white : Colors.red),
                      ),
                      controller: siteParams.passwordController,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/home');
                      if(siteParams.emailController.text.isEmpty && !siteParams.isChecked)
                      {
                        siteParams.checkTextFields(context);
                      }else{
                        if(siteParams.emailController.text.isNotEmpty)
                        {
                          siteParams.isChecked = false;
                          siteParams.checkTextFields(context);
                        }
                      }
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            ),
          ),
    ));
  }, listener: (BuildContext context , SiteStates) {  }));
  }

}