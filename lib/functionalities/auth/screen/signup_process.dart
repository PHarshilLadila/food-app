// // ignore_for_file: use_build_context_synchronously

// import 'package:country_pickers/country.dart';
// import 'package:country_pickers/country_picker_dropdown.dart';
// import 'package:country_pickers/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:food_app/constant/app_textform_field.dart';
// import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
// import 'package:food_app/functionalities/auth/screen/upload_photo.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class SignupProcess extends StatefulWidget {
//   const SignupProcess({super.key});

//   @override
//   State<SignupProcess> createState() => _SignupProcessState();
// }

// class _SignupProcessState extends State<SignupProcess> {
//   final TextEditingController fNameController = TextEditingController();
//   final TextEditingController lNameController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Future<void> proccess() async {
//     final FormState? form = _formKey.currentState;

//     if (form != null && form.validate()) {
//       try {
//         await Provider.of<AuthProviders>(context, listen: false).addUserDetails(
//           fNameController.text.trim(),
//           lNameController.text.trim(),
//           mobileController.text.trim(),
//         );
//         debugPrint(fNameController.text.trim());
//         debugPrint(lNameController.text.trim());
//         debugPrint(mobileController.text.trim());
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const UploadPhoto(),
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               e.toString(),
//             ),
//           ),
//         );
//         throw e.toString();
//       }
//     } else {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 70,
//         automaticallyImplyLeading: false,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               height: height * 0.03,
//               width: width * 0.8,
//               decoration: BoxDecoration(
//                 color: AppColors.lightOrange,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: AppColors.darkOrange,
//               ),
//             ),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         flexibleSpace: const Image(
//           image: AssetImage('assets/images/Pattern.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       backgroundColor: AppColors.whiteColor,
//       body: Consumer(
//         builder: (BuildContext context, value, Widget? child) {
//           return SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
//               child: LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   double screenWidth = constraints.maxWidth;
//                   double textFieldWidth = double.infinity;

//                   if (screenWidth > 1300) {
//                     debugPrint("screenWidth > 1300");
//                     textFieldWidth = height / 1.5;
//                   } else if (screenWidth > 1200 && screenWidth < 1300) {
//                     textFieldWidth = height / 1.5;
//                     debugPrint("screenWidth > 1200 && screenWidth < 1300");
//                   } else if (screenWidth > 1000 && screenWidth < 1200) {
//                     textFieldWidth = height / 1.5;
//                     debugPrint("screenWidth > 1000 && screenWidth < 1200");
//                     // Tablet view
//                   } else if (screenWidth > 800 && screenWidth < 1000) {
//                     textFieldWidth = height / 1.7;
//                     debugPrint("screenWidth > 800 && screenWidth < 1000");
//                   } else if (screenWidth > 600) {
//                     textFieldWidth = width / 1.7;
//                     debugPrint("screenWidth > 600 ");
//                   } else if (screenWidth > 500) {
//                     textFieldWidth = double.infinity;
//                     debugPrint("screenWidth > 500");
//                   } else if (screenWidth > 350) {
//                     textFieldWidth = double.infinity;
//                     debugPrint("screenWidth > 350");
//                   }
//                   return Form(
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         GradientText(
//                           // AppLocalizations.of(context)!.signupProcessTitle,
//                           "Fill in your bio to get started,",
//                           style: GoogleFonts.poppins(
//                               fontSize: 30, fontWeight: FontWeight.w600),
//                           gradient: const LinearGradient(
//                             colors: [
//                               AppColors.blackColor,
//                               AppColors.blackColor,
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         GradientText(
//                           // AppLocalizations.of(context)!.proccessData,
//                           "This data will be displayed in your account profile for security,",
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           gradient: const LinearGradient(
//                             colors: [
//                               AppColors.blackColor,
//                               AppColors.blackColor,
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         Center(
//                           child: SizedBox(
//                             width: textFieldWidth,
//                             child: CustomeTextFormField(
//                               maxline: 1,
//                               textEditingController: fNameController,
//                               hintText: " First Name",
//                               //  AppLocalizations.of(context)!.firstName,
//                               obscureText: false,
//                               fillColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               borderColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               disabledColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               enabledColor: AppColors.darkGreen,
//                               focusedColor: AppColors.darkGreen,
//                               hintcolors: const Color(
//                                 0xff3B3B3B,
//                               ),
//                               keyboradType: TextInputType.name,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         Center(
//                           child: SizedBox(
//                             width: textFieldWidth,
//                             child: CustomeTextFormField(
//                               maxline: 1,
//                               textEditingController: lNameController,
//                               hintText: "Last Name",
//                               //  AppLocalizations.of(context)!.lastName,
//                               obscureText: false,
//                               fillColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               borderColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               disabledColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               enabledColor: AppColors.darkGreen,
//                               focusedColor: AppColors.darkGreen,
//                               hintcolors: const Color(
//                                 0xff3B3B3B,
//                               ),
//                               keyboradType: TextInputType.name,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         Center(
//                           child: SizedBox(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 55,
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color: AppColors.darkGreen,
//                                       width: 1,
//                                     ),
//                                     color: const Color.fromARGB(
//                                         255, 252, 255, 252),
//                                   ),
//                                   child: Center(
//                                     child: CountryPickerDropdown(
//                                       initialValue: 'IN',
//                                       priorityList: [
//                                         CountryPickerUtils.getCountryByIsoCode(
//                                             'GB'),
//                                         CountryPickerUtils.getCountryByIsoCode(
//                                             'CN'),
//                                       ],
//                                       sortComparator: (Country a, Country b) =>
//                                           a.isoCode.compareTo(b.isoCode),
//                                       onValuePicked: (Country country) {
//                                         debugPrint(country.name);
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         height: 80,
//                                         child: CustomeTextFormField(
//                                           maxline: 1,
//                                           textEditingController:
//                                               mobileController,
//                                           hintText: "Mobile Number",
//                                           obscureText: false,
//                                           fillColor: const Color.fromARGB(
//                                               255, 252, 255, 252),
//                                           borderColor: const Color.fromARGB(
//                                               255, 252, 255, 252),
//                                           disabledColor: const Color.fromARGB(
//                                               255, 252, 255, 252),
//                                           enabledColor: AppColors.darkGreen,
//                                           focusedColor: AppColors.darkGreen,
//                                           hintcolors: const Color(0xff3B3B3B),
//                                           validator: (value) {
//                                             if (value == null ||
//                                                 value.isEmpty) {
//                                               return 'Please enter your Mobile Number';
//                                             }
//                                             if (value.length != 10) {
//                                               return 'Mobile Number must be of 10 digits';
//                                             }
//                                             return null;
//                                           },
//                                           keyboradType: TextInputType.number,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                           height: 4), // Spacing before error
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: GestureDetector(
//         onTap: () {
//           proccess();
//         },
//         child: Container(
//           width: width * 0.4,
//           height: height * 0.06,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15.0),
//             gradient: const LinearGradient(
//               begin: Alignment(-0.95, 0.0),
//               end: Alignment(1.0, 0.0),
//               colors: [
//                 Color(0xff53E88B),
//                 Color(0xff15BE77),
//               ],
//               stops: [0.0, 1.0],
//             ),
//           ),
//           child: Center(
//             child: Text(
//               "Next",
//               // AppLocalizations.of(context)!.next,
//               style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/auth/screen/upload_photo.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SignupProcess extends StatefulWidget {
  const SignupProcess({super.key});

  @override
  State<SignupProcess> createState() => _SignupProcessState();
}

class _SignupProcessState extends State<SignupProcess> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> proccess() async {
    try {
      await Provider.of<AuthProviders>(context, listen: false).addUserDetails(
        fNameController.text.trim(),
        lNameController.text.trim(),
        mobileController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UploadPhoto(),
        ),
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     backgroundColor: AppColors.darkGreen,
      //     behavior: SnackBarBehavior.floating,
      //     content: Text("Your profile details added successfully"),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
      appTostMessage(
        context,
        ToastificationType.success,
        "Your profile details added successfully",
        "assets/images/done.png",
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(e.toString()),
      //   ),
      // );
      appTostMessage(
        context,
        ToastificationType.error,
        e.toString(),
        "assets/images/wronge.png",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
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
        backgroundColor: Colors.transparent,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/Pattern.png'),
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Consumer(
        builder: (BuildContext context, value, Widget? child) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double screenWidth = constraints.maxWidth;
                  double textFieldWidth = double.infinity;

                  // Make text field width responsive
                  if (screenWidth > 1300) {
                    textFieldWidth = height / 1.5;
                  } else if (screenWidth > 1200 && screenWidth < 1300) {
                    textFieldWidth = height / 1.5;
                  } else if (screenWidth > 1000 && screenWidth < 1200) {
                    textFieldWidth = height / 1.5;
                  } else if (screenWidth > 800 && screenWidth < 1000) {
                    textFieldWidth = height / 1.7;
                  } else if (screenWidth > 600) {
                    textFieldWidth = width / 1.7;
                  } else {
                    textFieldWidth = double.infinity;
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        GradientText(
                          AppLocalizations.of(context)!.signupProcessTitle,
                          // "Fill in your bio to get started,",
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.blackColor,
                              AppColors.blackColor
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GradientText(
                          AppLocalizations.of(context)!.proccessData,

                          // "This data will be displayed in your account profile for security,",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.blackColor,
                              AppColors.blackColor
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // First Name
                        Center(
                          child: SizedBox(
                            width: textFieldWidth,
                            child: CustomeTextFormField(
                              maxline: 1,
                              textEditingController: fNameController,
                              hintText: AppLocalizations.of(context)!.firstName,

                              // "First Name",
                              obscureText: false,
                              fillColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              borderColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              disabledColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              enabledColor: AppColors.darkGreen,
                              focusedColor: AppColors.darkGreen,
                              hintcolors: const Color(0xff3B3B3B),
                              keyboradType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your First Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Last Name
                        Center(
                          child: SizedBox(
                            width: textFieldWidth,
                            child: CustomeTextFormField(
                              maxline: 1,
                              textEditingController: lNameController,
                              hintText: AppLocalizations.of(context)!.lastName,
                              //  "Last Name",
                              obscureText: false,
                              fillColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              borderColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              disabledColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              enabledColor: AppColors.darkGreen,
                              focusedColor: AppColors.darkGreen,
                              hintcolors: const Color(0xff3B3B3B),
                              keyboradType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your Last Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Mobile number with country picker
                        Center(
                          child: SizedBox(
                            width: textFieldWidth,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 55,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.darkGreen,
                                      width: 1,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 252, 255, 252),
                                  ),
                                  child: Center(
                                    child: CountryPickerDropdown(
                                      initialValue: 'IN',
                                      priorityList: [
                                        CountryPickerUtils.getCountryByIsoCode(
                                            'GB'),
                                        CountryPickerUtils.getCountryByIsoCode(
                                            'CN'),
                                      ],
                                      sortComparator: (Country a, Country b) =>
                                          a.isoCode.compareTo(b.isoCode),
                                      onValuePicked: (Country country) {
                                        debugPrint(country.name);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: SizedBox(
                                    height: 80,
                                    child: CustomeTextFormField(
                                      maxline: 1,
                                      textEditingController: mobileController,
                                      hintText: "Mobile Number",
                                      maxlength: 10,
                                      obscureText: false,
                                      fillColor: const Color.fromARGB(
                                          255, 252, 255, 252),
                                      borderColor: const Color.fromARGB(
                                          255, 252, 255, 252),
                                      disabledColor: const Color.fromARGB(
                                          255, 252, 255, 252),
                                      enabledColor: AppColors.darkGreen,
                                      focusedColor: AppColors.darkGreen,
                                      hintcolors: const Color(0xff3B3B3B),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your Mobile Number';
                                        }
                                        if (value.length != 10) {
                                          return 'Mobile Number must be of 10 digits';
                                        }
                                        return null;
                                      },
                                      keyboradType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            proccess();
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
              // "Next",
              AppLocalizations.of(context)!.next,
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
