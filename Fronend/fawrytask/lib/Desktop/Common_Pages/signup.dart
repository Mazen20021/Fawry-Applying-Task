import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:fawrytask/Desktop/Config/Server/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatelessWidget
{
  const Signup({super.key});
  
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
          Stack(
            children:[ 
              Center(
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  color: CustomColors.cards.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                     Text('Signup', style: GoogleFonts.meaCulpa(fontSize: 100,color: CustomColors.background , fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: 550,
                      child: TextFormField(
                         validator: (value) {
                                if (value?.isEmpty == true) {
                                  siteParams.isEmpty = true;
                                  return 'User Name cannot be empty';
                                }else {
                                  return null;
                                }
                              },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration:  InputDecoration(
                           errorStyle: GoogleFonts.aBeeZee(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 247, 108, 98),
                                ),
                          fillColor: CustomColors.background,
                          filled: true,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color:  CustomColors.background)),
                          hoverColor: CustomColors.background,
                          prefixIcon: const Icon(Icons.person_2_rounded, color: Colors.white,),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color:  CustomColors.cards )),
                          labelText: 'User Name',
                          labelStyle: TextStyle(color: Colors.white  ),
                          hintStyle: TextStyle(color:  Colors.white ),
                        ),
                        controller: siteParams.nameController,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: 550,
                      child: TextFormField(
                         validator: (value) {
                                if (value?.isEmpty == true) {
                                  siteParams.isEmpty = true;
                                  return 'Email cannot be empty';
                                }else {
                                  return null;
                                }
                              },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration:  InputDecoration(
                           errorStyle: GoogleFonts.aBeeZee(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 247, 108, 98),
                                ),
                          fillColor: CustomColors.background,
                          filled: true,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color:  CustomColors.background )),
                          hoverColor: CustomColors.background,
                          prefixIcon: const Icon(Icons.email, color: Colors.white,),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: CustomColors.cards )),
                          labelText: 'Email',
                          labelStyle: TextStyle(color:  Colors.white ),
                          hintStyle: TextStyle(color: Colors.white ),
                        ),
                        controller: siteParams.emailController,
                      ),
                    ),
                     const SizedBox(height: 10,),
                      SizedBox(
                        width: 550,
                        child: TextFormField(
                            validator: (value) {
                                if (value?.isEmpty == true) {
                                  siteParams.isEmpty = true;
                                  return 'Password cannot be empty';
                                }else if(siteParams.passwordController.text != siteParams.confirmPasswordController.text){
                                  siteParams.isEmpty = true;
                                  return 'Passwords is not the same';
                                }
                                return null;
                              },
                          obscureText:siteParams.isPasswordHidden? true : false ,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration:  InputDecoration(
                             errorStyle: GoogleFonts.aBeeZee(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 247, 108, 98),
                                ),
                            suffixIcon: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: (){
                                  siteParams.hidePassword(context);
                                },
                              child: Icon(siteParams.isPasswordHidden? Icons.visibility_off_rounded : Icons.visibility_rounded, color: Colors.white,),

                              ),),
                            fillColor:CustomColors.background,
                            filled: true,
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: CustomColors.background )),
                            hoverColor: CustomColors.background,
                            prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.white,),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color:  CustomColors.cards )),
                            labelText: 'Password',
                            labelStyle: TextStyle(color:  Colors.white ),
                            hintStyle: TextStyle(color:  Colors.white ),
                          ),
                          controller: siteParams.passwordController,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: 550,
                        child: TextFormField(
                            validator: (value) {
                                if (value?.isEmpty == true) {
                                  siteParams.isEmpty = true;
                                  return 'Password cannot be empty';
                                }else if(siteParams.passwordController.text != siteParams.confirmPasswordController.text){
                                  siteParams.isEmpty = true;
                                  return 'Passwords is not the same';
                                }
                                return null;
                              },
                          obscureText: siteParams.isConfirmPasswordHidden? true : false,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration:  InputDecoration(
                             errorStyle: GoogleFonts.aBeeZee(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 247, 108, 98),
                                ),
                            suffixIcon: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: (){
                                  siteParams.hideConfirmPassword(context);
                                },
                              child: Icon(siteParams.isConfirmPasswordHidden? Icons.visibility_off_rounded : Icons.visibility_rounded, color: Colors.white,),

                              ),),
                            fillColor:CustomColors.background,
                            filled: true,
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color:  CustomColors.background )),
                            hoverColor: CustomColors.background,
                            prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.white,),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color:  CustomColors.cards )),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color:Colors.white),
                            hintStyle: TextStyle(color: Colors.white )
                          ),
                          controller: siteParams.confirmPasswordController,
                        ),
                      ),
                    const SizedBox(height: 10,),
                      siteParams.isLoading? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(CustomColors.background),
                      backgroundColor: const Color.fromARGB(255, 142, 172, 108),
                    ) :
                    MouseRegion(
                      onEnter: (event) => {
                        siteParams.enteredOnLoginButton(context)
                      },
                      onExit: (event) => {
                        siteParams.enteredOnLoginButton(context)
                      },
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          if (siteParams.key.currentState?.validate() == true) {
                            siteParams.checkUser(context);
                            bool isEqual = siteParams.passwordController.text == siteParams.confirmPasswordController.text;
                          if(isEqual){
                            if(await Server.signup(siteParams.emailController.text, siteParams.passwordController.text,siteParams.nameController.text)){
                              ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.black,
                                              content:  Center(child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('User Created Successfully', style: GoogleFonts.dmMono(fontSize: 20,color: CustomColors.cards , fontWeight: FontWeight.bold),),
                                                  const SizedBox(width: 10,),
                                                  Icon(Icons.done_outlined , color: Colors.green, size: 30,)
                                                ],
                                              )),
                                              
                                            ),
                                          );
                              Navigator.pushNamed(context, '/login');
                            }
                          }else{
                            siteParams.isLoading = false;
                             
                         }
                        siteParams.checkUser(context);
                          }
                          
                        },
                        child: Container(
                          width: 550,
                          height: 50,
                          decoration: BoxDecoration(
                            color: siteParams.enteredOnLogin? Color.fromARGB(255, 42, 51, 32) : CustomColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text('Signup', style: GoogleFonts.dmMono(fontSize: 32,color: siteParams.enteredOnLogin? Color.fromARGB(255, 255, 255, 255) :  CustomColors.cards , fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You have an account? ", style: GoogleFonts.dmMono(fontSize: 20,color: CustomColors.background ),),
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
                               Navigator.pushNamed(context, '/login');
                            },
                            child: Text('Login', style: GoogleFonts.dmMono(fontSize: 20,color:siteParams.enteredOnSignup?Colors.white :CustomColors.background , fontWeight: FontWeight.bold),),
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
      // Server.connect("
}, listener: (BuildContext context, SiteStates state) {},
    ));}
    }