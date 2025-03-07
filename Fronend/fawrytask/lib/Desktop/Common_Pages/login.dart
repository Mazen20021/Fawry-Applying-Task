import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:fawrytask/Desktop/Config/Server/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
      Server.connect("mazen2040@gmail.com", "0000");
    return Form(
      key: siteParams.key,
      child: Scaffold(
      backgroundColor: CustomColors.background,
      body: 
          Stack(
            children:[ 
              Center(
              child: Container(
                width: 600,
                height: 500,
                decoration: BoxDecoration(
                  color: CustomColors.cards.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                     Text('Welcome', style: GoogleFonts.meaCulpa(fontSize: 100,color: CustomColors.background , fontWeight: FontWeight.bold),),
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
                            fillColor:CustomColors.background,
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
                    const SizedBox(height: 20,),
                    MouseRegion(
                      onEnter: (event) => {
                        siteParams.enteredOnLoginButton(context)
                      },
                      onExit: (event) => {
                        siteParams.enteredOnLoginButton(context)
                      },
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          
                        },
                        child: Container(
                          width: 550,
                          height: 50,
                          decoration: BoxDecoration(
                            color: siteParams.enteredOnLogin? Color.fromARGB(255, 42, 51, 32) : CustomColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text('Login', style: GoogleFonts.dmMono(fontSize: 32,color: siteParams.enteredOnLogin? Color.fromARGB(255, 255, 255, 255) :  CustomColors.cards , fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: GoogleFonts.dmMono(fontSize: 20,color: CustomColors.background ),),
                        MouseRegion(
                          onEnter: (event) => {
                            siteParams.enteredOnSignupButton(context)
                          },
                          onExit: (event) => {
                            siteParams.enteredOnSignupButton(context)
                          },
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: (){
                              siteParams.checkTextFields(context);
                            },
                            child: Text('Signup', style: GoogleFonts.dmMono(fontSize: 20,color:siteParams.enteredOnSignup?Colors.white :CustomColors.background , fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
    ));
  }, listener: (BuildContext context , siteStates) {}));
  }

}