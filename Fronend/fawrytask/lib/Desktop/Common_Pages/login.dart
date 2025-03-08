import 'package:fawrytask/Desktop/Config/Constants/custom_colors.dart';
import 'package:fawrytask/Desktop/Config/Cubit/cubit.dart';
import 'package:fawrytask/Desktop/Config/Cubit/states.dart';
import 'package:fawrytask/Desktop/Config/Server/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => SiteCubit(),
      child: BlocConsumer<SiteCubit, SiteStates>(
        builder: (BuildContext context, states) {
          SiteCubit siteParams = SiteCubit.get(context);
          return Form(
            key: siteParams.key,
            child: Scaffold(
              backgroundColor: CustomColors.background,
              body: Stack(
                children: [
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
                          const SizedBox(height: 20),
                          Text(
                            'Welcome',
                            style: GoogleFonts.meaCulpa(
                              fontSize: 100,
                              color: CustomColors.background,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 550,
                            child: TextFormField(
                              
                              validator: (value) {
                                if (value?.isEmpty == true) {

                                  return 'Email cannot be empty';
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
                                        ? CustomColors.background
                                        : Colors.red,
                                  ),
                                ),
                                hoverColor: CustomColors.background,
                                prefixIcon: const Icon(
                                  Icons.email,
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
                                labelText: 'Email',
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
                              controller: siteParams.emailController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 550,
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  siteParams.isEmpty = true;
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                              obscureText: siteParams.isPasswordHidden,
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
                                        ? CustomColors.background
                                        : Colors.red,
                                  ),
                                ),
                                hoverColor: CustomColors.background,
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white,
                                ),
                                suffixIcon: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      siteParams.hidePassword(context);
                                    },
                                    child: Icon(
                                      siteParams.isPasswordHidden
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: siteParams.isEmpty
                                        ? CustomColors.cards
                                        : Colors.red,
                                  ),
                                ),
                                labelText: 'Password',
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
                              controller: siteParams.passwordController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          siteParams.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CustomColors.background),
                                  backgroundColor:
                                      const Color.fromARGB(255, 142, 172, 108),
                                )
                              : MouseRegion(
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
                                        String userType = await Server.login(
                                            siteParams.emailController.text,
                                            siteParams.passwordController.text);
                                        if (userType == "Admin") {
                                          siteParams.isLoading = false;
                                          Navigator.pushNamed(context, '/home/admin');
                                        } else if (userType == "User") {
                                          Navigator.pushNamed(context, '/home');
                                        } else {
                                          siteParams.checkUser(context);
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 550,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: siteParams.enteredOnLogin
                                            ? Color.fromARGB(255, 42, 51, 32)
                                            : CustomColors.background,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: GoogleFonts.dmMono(
                                            fontSize: 32,
                                            color: siteParams.enteredOnLogin
                                                ? Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : CustomColors.cards,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.dmMono(
                                  fontSize: 20,
                                  color: CustomColors.background,
                                ),
                              ),
                              MouseRegion(
                                onEnter: (event) => {
                                  siteParams.enteredOnSignupButton(context)
                                },
                                onExit: (event) => {
                                  siteParams.enteredOnSignupButton(context)
                                },
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    'Signup',
                                    style: GoogleFonts.dmMono(
                                      fontSize: 20,
                                      color: siteParams.enteredOnSignup
                                          ? Colors.white
                                          : CustomColors.background,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, SiteStates state) {},
      ),
    );
  }
}