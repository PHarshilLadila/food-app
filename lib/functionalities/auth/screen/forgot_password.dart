import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: height * 0.03,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.lightOrange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.darkOrange,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/Pattern.png'),
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: const Color(0xffFEFEFF),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Consumer<AuthProviders>(
          builder: (BuildContext context, AuthProviders value, Widget? child) {
            return LayoutBuilder(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      GradientText(
                        'Forgot password?',
                        style: GoogleFonts.poppins(
                            fontSize: 30, fontWeight: FontWeight.w600),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.blackColor,
                            AppColors.blackColor,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      GradientText(
                        'This data will be displayed in your account profile for security',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.blackColor,
                            AppColors.blackColor,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Center(
                        child: Container(
                          width: textFieldWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 250, 255, 251),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 12,
                                offset: Offset(2, 5),
                                color: Color.fromARGB(255, 219, 219, 219),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/login/message.png",
                                      height: height * 0.04,
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GradientText(
                                          'Via email :',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors.blackColor,
                                              AppColors.blackColor,
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        GradientText(
                                          '(We will send you a link to reset \nyour password)',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors.blackColor,
                                              AppColors.blackColor,
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                SizedBox(
                                  width: textFieldWidth,
                                  child: Form(
                                    key: formKey,
                                    child: CustomeTextFormField(
                                      textEditingController: emailController,
                                      maxline: 1,
                                      fillColor:
                                          Color.fromARGB(255, 252, 255, 252),
                                      hintText: "Email (John.example.com)",
                                      obscureText: false,
                                      hintcolors: Color(
                                        0xff3B3B3B,
                                      ),
                                      borderColor:
                                          Color.fromARGB(255, 252, 255, 252),
                                      disabledColor:
                                          Color.fromARGB(255, 252, 255, 252),
                                      enabledColor: AppColors.darkGreen,
                                      focusedColor: AppColors.darkGreen,
                                      keyboradType: TextInputType.emailAddress,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          if (formKey.currentState!.validate()) {
            Provider.of<AuthProviders>(context, listen: false)
                .forgotPassword(emailController.text.trim());

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     behavior: SnackBarBehavior.floating,
            //     content: Text("Email sent successfully on ${emailController.text.trim()}"),
            //     backgroundColor: AppColors.darkGreen,
            //     duration: Duration(seconds: 2),
            //   ),
            // );
            appTostMessage(
                context,
                ToastificationType.success,
                "Email sent successfully on ${emailController.text.trim()}",
                "assets/images/done.png");

            Navigator.pop(context);
          }
        },
        child: Container(
          width: width * 0.4,
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
              "Send Email",
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
