// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/auth/screen/forgot_password.dart';
import 'package:food_app/functionalities/auth/screen/sign_up_screen.dart';
import 'package:food_app/functionalities/auth/screen/signup_process.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // void login() async {
  //   try {

  //     await Provider.of<AuthProviders>(context, listen: false).login(
  //       emailController.text.trim(),
  //       passwordController.text.trim(),
  //     );
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const BottomScreen()),
  //       (route) => false,
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           e.toString(),
  //         ),
  //       ),
  //     );
  //     throw e.toString();
  //   }
  // }
  bool showPasswords = true;

  void toggleShowPassword() {
    setState(() {
      showPasswords = !showPasswords;
    });
  }

  void login() async {
    try {
      await Provider.of<AuthProviders>(context, listen: false).login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Only if login succeeds, navigate to the home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BottomScreen()),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("Login Successful, welcome back to Swift Bite"),
          backgroundColor: AppColors.darkGreen,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(e.toString().replaceAll("Exception: ", "")),
        ),
      );
    }
  }

  // void login() async {
  //   try {
  //     await Provider.of<AuthProviders>(context, listen: false).login(
  //       emailController.text.trim(),
  //       passwordController.text.trim(),
  //     );
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const BottomScreen()),
  //       (route) => false,
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         behavior: SnackBarBehavior.floating,
  //         content: Text("Login Successful, welcome back to Swift Bite"),
  //         backgroundColor: AppColors.darkGreen,
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Colors.red,
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        double textFieldWidth = double.infinity;
        double containerHeight = height / 15;
        double containerWidth = width / 2;

        if (screenWidth > 1300) {
          debugPrint("screenWidth > 1300");
          textFieldWidth = height / 1.5;
          containerWidth = width / 6.4;
        } else if (screenWidth > 1200 && screenWidth < 1300) {
          textFieldWidth = height / 1.5;
          containerWidth = width / 6;
          debugPrint("screenWidth > 1200 && screenWidth < 1300");
        } else if (screenWidth > 1000 && screenWidth < 1200) {
          textFieldWidth = height / 1.5;
          containerWidth = width / 5;
          debugPrint("screenWidth > 1000 && screenWidth < 1200");
          // Tablet view
        } else if (screenWidth > 800 && screenWidth < 1000) {
          textFieldWidth = height / 1.7;
          containerWidth = width / 4;
          debugPrint("screenWidth > 800 && screenWidth < 1000");
        } else if (screenWidth > 600) {
          textFieldWidth = width / 1.7;
          containerWidth = width / 3.5;
          debugPrint("screenWidth > 600 ");
        } else if (screenWidth > 500) {
          textFieldWidth = double.infinity;
          containerWidth = width / 3;
          debugPrint("screenWidth > 500");
        } else if (screenWidth > 350) {
          textFieldWidth = double.infinity;
          containerWidth = width / 2;
          debugPrint("screenWidth > 350");
        }

        return Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                      // ignore: deprecated_member_use
                      Colors.white.withOpacity(0.2),
                      BlendMode.dstATop),
                  image: AssetImage(
                    "assets/images/Pattern.png",
                  ),
                ),
              ),
              child: Consumer<AuthProviders>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.isLoading) {
                    return Center(child: myProccesser());
                  } else {
                    return child!;
                  }
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
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
                          // AppLocalizations.of(context)!.loginAccount,
                          "Login To Your Account",
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
                        Column(
                          children: [
                            SizedBox(
                              width: textFieldWidth,
                              child: CustomeTextFormField(
                                maxline: 1,
                                key: const Key('email'),
                                textEditingController: emailController,
                                hintText: "Email",
                                //  AppLocalizations.of(context)!.email,
                                obscureText: false,
                                fillColor:
                                    const Color.fromARGB(255, 252, 255, 252),
                                borderColor:
                                    const Color.fromARGB(255, 252, 255, 252),
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
                                key: const Key('password'),

                                maxline: 1,
                                textEditingController: passwordController,
                                hintText: "Password",
                                // AppLocalizations.of(context)!.password,
                                obscureText: showPasswords,
                                borderColor:
                                    const Color.fromARGB(255, 252, 255, 252),
                                disabledColor:
                                    const Color.fromARGB(255, 252, 255, 252),
                                fillColor:
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
                                  if (!value.contains(
                                      RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                                    return "Password must contain at least one special character";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                key: const Key('login_button'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ),
                                  );
                                },
                                child: GradientText(
                                  // AppLocalizations.of(context)!.forgotPass,
                                  "Forgot Your Password?",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.lightGreen,
                                      AppColors.darkGreen,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            kIsWeb
                                ? SizedBox()
                                : SizedBox(
                                    height: height * 0.03,
                                  ),
                            kIsWeb
                                ? SizedBox()
                                : GradientText(
                                    // AppLocalizations.of(context)!.countinueWith,
                                    "or Continue With",
                                    style: GoogleFonts.viga(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff09051C),
                                        Color(0xff09051C),
                                      ],
                                    ),
                                  ),
                            kIsWeb
                                ? SizedBox()
                                : SizedBox(
                                    height: height * 0.03,
                                  ),
                            kIsWeb
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          width: containerWidth,
                                          height: containerHeight,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffF4F4F4),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                              begin: Alignment(-0.95, 0.0),
                                              end: Alignment(1.0, 0.0),
                                              colors: [
                                                AppColors.whiteColor,
                                                AppColors.whiteColor,
                                              ],
                                              stops: [0.0, 1.0],
                                            ),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/fb.png",
                                                  height: height * 0.04,
                                                ),
                                                SizedBox(
                                                  width: width / 60,
                                                ),
                                                Text(
                                                  // AppLocalizations.of(context)!
                                                  //     .facebook,
                                                  'Facebook',
                                                  style: GoogleFonts.poppins(
                                                    color: AppColors.blackColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            var googUserId =
                                                prefs.get("googleAuthUID");

                                            if (googUserId == null) {
                                              Provider.of<AuthProviders>(
                                                      context,
                                                      listen: false)
                                                  .signInWithGoogle(context);
                                              await Future.delayed(
                                                  const Duration(seconds: 4));
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SignupProcess()),
                                                (route) => false,
                                              );
                                            } else {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomScreen()),
                                                (route) => false,
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: containerWidth,
                                            height: containerHeight,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffF4F4F4),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: const LinearGradient(
                                                begin: Alignment(-0.95, 0.0),
                                                end: Alignment(1.0, 0.0),
                                                colors: [
                                                  AppColors.whiteColor,
                                                  AppColors.whiteColor,
                                                ],
                                                stops: [0.0, 1.0],
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/google.png",
                                                    height: height * 0.04,
                                                  ),
                                                  SizedBox(
                                                    width: width / 60,
                                                  ),
                                                  Text(
                                                    // AppLocalizations.of(context)!
                                                    //     .google,
                                                    "Google",
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  login();
                                }
                              },
                              child: Container(
                                width: width / 4,
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
                                    // AppLocalizations.of(context)!.login,
                                    "Login",
                                    style: GoogleFonts.poppins(
                                        color: AppColors.whiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                Sentry.captureMessage(
                                    "Press SignUp Button for go to Register Screen");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: GradientText(
                                // AppLocalizations.of(context)!.dontHaveAccount,
                                "Don't Have An Account?",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
