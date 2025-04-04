// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/auth/screen/login_screen.dart';
import 'package:food_app/functionalities/auth/screen/signup_process.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool first = false;
  bool second = false;
  bool? isChecked = true;

  bool showPasswords = true;

  void toggleShowPassword() {
    setState(() {
      showPasswords = !showPasswords;
    });
  }

  void register() async {
    final FormState? form = _formKey.currentState;
    if (form != null && form.validate()) {
      try {
        await Provider.of<AuthProviders>(context, listen: false).register(
            emailController.text.trim(),
            passwordController.text.trim(),
            userNameController.text.trim());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SignupProcess(),
          ),
          (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
        throw e.toString();
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              colorFilter: ColorFilter.mode(
                  // ignore: deprecated_member_use
                  Colors.white.withOpacity(0.2),
                  BlendMode.dstATop),
              image: AssetImage(
                "assets/images/Pattern.png",
              ),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double screenWidth = constraints.maxWidth;
              double textFieldWidth = double.infinity;

              if (screenWidth > 1300) {
                debugPrint("screenWidth > 1300");
                textFieldWidth = height / 1.5;
              } else if (screenWidth > 1200 && screenWidth < 1300) {
                textFieldWidth = height / 1.5;
                debugPrint("screenWidth > 1200 && screenWidth < 1300");
              } else if (screenWidth > 1000 && screenWidth < 1200) {
                textFieldWidth = height / 1.5;
                debugPrint("screenWidth > 1000 && screenWidth < 1200");
                // Tablet view
              } else if (screenWidth > 800 && screenWidth < 1000) {
                textFieldWidth = height / 1.7;
                debugPrint("screenWidth > 800 && screenWidth < 1000");
              } else if (screenWidth > 600) {
                textFieldWidth = width / 1.7;
                debugPrint("screenWidth > 600 ");
              } else if (screenWidth > 500) {
                textFieldWidth = double.infinity;
                debugPrint("screenWidth > 500");
              } else if (screenWidth > 350) {
                textFieldWidth = double.infinity;
                debugPrint("screenWidth > 350");
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.08),
                        child: Image.asset(
                          "assets/images/splash/Logo.png",
                        ),
                      ),
                      GradientText(
                        // AppLocalizations.of(context)!.swiftBite,
                        "Swift Bite",
                        style: GoogleFonts.viga(
                            fontSize: 40, fontWeight: FontWeight.w400),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.lightGreen,
                            AppColors.darkGreen,
                          ],
                        ),
                      ),
                      Text(
                        // AppLocalizations.of(context)!.slogun,
                        "Deliver Favorite Food",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      SizedBox(
                        height: height * 0.10,
                      ),
                      GradientText(
                        'Sign Up For Free ',
                        style: GoogleFonts.viga(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.blackColor,
                            AppColors.blackColor,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      SizedBox(
                        width: textFieldWidth,
                        child: CustomeTextFormField(
                          maxline: 1,
                          hintText: "User Name",
                          // AppLocalizations.of(context)!.userName,
                          textEditingController: userNameController,
                          obscureText: false,
                          fillColor: const Color.fromARGB(255, 252, 255, 252),
                          borderColor: const Color.fromARGB(255, 252, 255, 252),
                          disabledColor:
                              const Color.fromARGB(255, 252, 255, 252),
                          enabledColor: AppColors.darkGreen,
                          focusedColor: AppColors.darkGreen,
                          hintcolors: const Color(
                            0xff3B3B3B,
                          ),
                          keyboradType: TextInputType.name,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/login/profile.png",
                              height: height * 0.001,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your user name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: textFieldWidth,
                        child: CustomeTextFormField(
                          maxline: 1,
                          textEditingController: emailController,
                          hintText: "Email",
                          //  AppLocalizations.of(context)!.email,
                          obscureText: false,
                          fillColor: const Color.fromARGB(255, 252, 255, 252),
                          borderColor: const Color.fromARGB(255, 252, 255, 252),
                          disabledColor:
                              const Color.fromARGB(255, 252, 255, 252),
                          enabledColor: AppColors.darkGreen,
                          focusedColor: AppColors.darkGreen,
                          hintcolors: const Color(
                            0xff3B3B3B,
                          ),
                          keyboradType: TextInputType.emailAddress,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/login/message.png",
                              height: height * 0.01,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(value)) {
                              return "Please enter a valid email address";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: textFieldWidth,
                        child: CustomeTextFormField(
                          maxline: 1,
                          textEditingController: passwordController,
                          hintText: "Password",
                          //  AppLocalizations.of(context)!.password,
                          obscureText: showPasswords,
                          fillColor: const Color.fromARGB(255, 252, 255, 252),
                          borderColor: const Color.fromARGB(255, 252, 255, 252),
                          disabledColor:
                              const Color.fromARGB(255, 252, 255, 252),
                          enabledColor: AppColors.darkGreen,
                          focusedColor: AppColors.darkGreen,
                          hintcolors: const Color(
                            0xff3B3B3B,
                          ),
                          keyboradType: TextInputType.visiblePassword,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/login/lock.png",
                              height: height * 0.01,
                            ),
                          ),
                          sufixIcon: IconButton(
                            onPressed: toggleShowPassword,
                            icon: showPasswords
                                ? const FaIcon(
                                    FontAwesomeIcons.eyeSlash,
                                    size: 20,
                                    color: Colors.black,
                                    semanticLabel: "Password",
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.eye,
                                    size: 20,
                                    color: Colors.black,
                                    semanticLabel: "Password",
                                  ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password should have atleast 8 characters';
                            }
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return "Password must contain at least one uppercase letter";
                            }
                            if (!value.contains(RegExp(r'[a-z]'))) {
                              return "Password must contain at least one lowercase  letter";
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return "Password must contain at least one numeric character";
                            }
                            if (!value
                                .contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                              return "Password must contain at least one special character";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: height / 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          register();
                        },
                        child: Container(
                          width: width / 3.1,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: const LinearGradient(
                              begin: Alignment(-0.95, 0.0),
                              end: Alignment(1.0, 0.0),
                              colors: [
                                Color(0xff53E88B),
                                Color(0xff15BE77),
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              // AppLocalizations.of(context)!.createAccount,
                              "Create Account",
                              style: GoogleFonts.poppins(
                                color: AppColors.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: GradientText(
                          "You Already Have Account?", // AppLocalizations.of(context)!.dontHaveAccount,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.lightGreen,
                              AppColors.darkGreen,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
