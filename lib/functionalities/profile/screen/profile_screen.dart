// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_sctring.dart';
import 'package:food_app/functionalities/3d%20avatar/local_3d_model.dart';
import 'package:food_app/functionalities/3d%20avatar/my_3d_avatar.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/auth/screen/login_screen.dart';
import 'package:food_app/functionalities/custom%20paint/snow_fall.dart';
import 'package:food_app/functionalities/profile/screen/fevorite_items.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/screen/help_support.dart';
import 'package:food_app/functionalities/profile/screen/my_profile.dart';
import 'package:food_app/functionalities/profile/screen/privacy.dart';
import 'package:food_app/functionalities/profile/screen/setting.dart';
import 'package:food_app/functionalities/profile/screen/term_and_condition.dart';
import 'package:food_app/functionalities/profile/screen/three_avatar_error_handler.dart';
import 'package:food_app/functionalities/profile/widgets/vertocal_container_button.dart';
import 'package:food_app/functionalities/profile/widgets/widgets.dart';
import 'package:food_app/functionalities/track%20order/screens/track_order.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:o3d/o3d.dart';
import 'package:provider/provider.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final O3DController controller = O3DController();

  // final FlutterSecureStorage storage = const FlutterSecureStorage();

  bool isFront = true;
  bool isLoading = false;

  bool is2Dimage = false;
  bool is3DImage = false;
  String? twoDImage = "";
  String? threeDImage = "";

  // getStored2DImage() async {
  //   var data = await storage.read(key: "FinalTwoDImagePath");

  //   setState(() {
  //     twoDImage = data;
  //     debugPrint(
  //         "THIS IS  GET THE FINAL 2D IMAGE PATH FROM SECURE STORAGE ::: ::: ::: $twoDImage");
  //     if (twoDImage == null) {
  //       is2Dimage = false;
  //     } else if (twoDImage != null) {
  //       is2Dimage = true;
  //     }
  //   });
  // }

  getStored2DImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      twoDImage = preferences.getString("FinalTwoDImagePath");
      if (twoDImage == null) {
        is2Dimage = false;
      } else if (twoDImage != null) {
        is2Dimage = true;
      }
    });
  }

  // getStored3DImage() async {
  //   final log = Logger('MyAwesomeLogger');
  //   log.info('a breadcrumb for get  the stored 3d image in shred preference!');

  //   try {
  //     var data = await storage.read(key: "finalThreeDImagePath");

  //     setState(() {
  //       threeDImage = data;
  //       debugPrint(
  //           "THIS IS GET THE FINAL 3D IMAGE PATH FROM SECURE STORAGE ::: ::: ::: $threeDImage");
  //       if (threeDImage == null) {
  //         is3DImage = false;
  //       } else if (threeDImage != null) {
  //         is3DImage = true;
  //       }
  //     });
  //   } catch (error, stackTrace) {
  //     log.severe('an error to get the stored 3d image in shared preference!',
  //         error, stackTrace);
  //   }
  // }

  getStored3DImage() async {
    final log = Logger('MyAwesomeLogger');
    log.info('a breadcrumb for get  the stored 3d image in shred preference!');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        threeDImage = preferences.getString("finalThreeDImagePath");
        if (threeDImage == null) {
          is3DImage = false;
        } else if (threeDImage != null) {
          is3DImage = true;
        }
      });
    } catch (error, stackTrace) {
      log.severe('an error to get the stored 3d image in shared preference!',
          error, stackTrace);
    }
  }

  @override
  void initState() {
    super.initState();

    // Sentry.configureScope((scope) => scope.level = SentryLevel.warning);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {});
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).profile;
      Provider.of<ProfileProvider>(context, listen: false).getUserData();
    });

    getStored2DImage();
    getStored3DImage();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // void _flipCard() {
  //   if (animationController.status != AnimationStatus.forward) {
  //     if (isFront) {
  //       animationController.forward();
  //     } else {
  //       animationController.reverse();
  //     }
  //     isFront = !isFront;
  //   }
  // }
  void _flipCard() {
    if (animationController.isAnimating)
      return; // Prevent multiple taps during animation

    if (isFront) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    isFront = !isFront;
  }

  // Widget _buildFront() {
  //   var provider = Provider.of<ProfileProvider>(context, listen: false).profile;
  //   var myProfile = provider?.profileImage!;

  //   if (myProfile!.isEmpty) {
  //     myProccesser();
  //   }
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: const Color.fromARGB(255, 203, 238, 205),
  //         borderRadius: BorderRadius.circular(15)),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(15.0),
  //       child: Image.memory(
  //         fit: BoxFit.cover,
  //         base64Decode(myProfile!),
  //         height: 140.0,
  //         width: 140.0,
  //       ),
  //     ),
  //   );
  // }
  Widget _buildFront() {
    var provider = Provider.of<ProfileProvider>(context, listen: false).profile;
    var myProfile = provider?.profileImage;

    if (myProfile == null || myProfile.isEmpty) {
      myProccesser();
    }

    final String imageBase64 = (myProfile != null && myProfile.isNotEmpty)
        ? myProfile
        : AppString.defaultImage;
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 203, 238, 205),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FutureBuilder<Uint8List>(
          future: Future.delayed(const Duration(seconds: 1), () {
            return base64Decode(imageBase64);
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myProccesser(),
              );
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                child: Icon(Icons.error, color: Colors.red),
              );
            } else {
              return Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
                height: 140.0,
                width: 140.0,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.14),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 203, 238, 205),
          border: Border.all(
            color: AppColors.darkGreen,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: is2Dimage
              ? Stack(
                  children: [
                    !is3DImage
                        ? Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 203, 238, 205),
                              border: Border.all(
                                color: AppColors.darkGreen,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FutureBuilder(
                              future:
                                  Future.delayed(const Duration(seconds: 2)),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return Center(
                                    child: myProccesser(),
                                  );
                                }
                                return O3D(
                                  controller: controller,
                                  src:
                                      threeDImage ?? "assets/images/avatar.glb",
                                  alt: "3D Model of Avatar",
                                  autoRotate: true,
                                  cameraControls: true,
                                );
                              },
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              twoDImage ??
                                  "https://cdn3.iconfinder.com/data/icons/nft-blockchain-technology-rich-series/256/PFP-512.png",
                              fit: BoxFit.cover,
                              width: 140,
                              height: 140,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: myProccesser(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error,
                                    color: Colors.red);
                              },
                            ),
                          ),
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            is3DImage = !is3DImage;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 88, 5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                is3DImage ? "2D" : "3D",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      twoDImage ??
                          "https://cdn3.iconfinder.com/data/icons/nft-blockchain-technology-rich-series/256/PFP-512.png",
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: Colors.red);
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // Widget _buildBack() {
  //   return Transform(
  //     alignment: Alignment.center,
  //     transform: Matrix4.rotationY(3.14),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: const Color.fromARGB(255, 203, 238, 205),
  //         border: Border.all(
  //           color: AppColors.darkGreen,
  //           width: 0.5,
  //         ),
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       child: Center(
  //         child: is2Dimage
  //             ? Stack(
  //                 children: [
  //                   !is3DImage
  //                       ? Container(
  //                           width: 140,
  //                           height: 140,
  //                           decoration: BoxDecoration(
  //                             color: const Color.fromARGB(255, 203, 238, 205),
  //                             border: Border.all(
  //                               color: AppColors.darkGreen,
  //                               width: 0.5,
  //                             ),
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           child: O3D(
  //                             controller: controller,
  //                             src: threeDImage ?? "assets/images/avatar.glb",
  //                             alt: "3D Model of Avatar",
  //                             autoRotate: true,
  //                             cameraControls: true,
  //                           ),
  //                         )
  //                       : ClipRRect(
  //                           borderRadius: BorderRadius.circular(15),
  //                           child: Image.network(
  //                             twoDImage ??
  //                                 "https://cdn3.iconfinder.com/data/icons/nft-blockchain-technology-rich-series/256/PFP-512.png",
  //                             fit: BoxFit.cover,
  //                             width: 140,
  //                             height: 140,
  //                           ),
  //                         ),
  //                   Positioned(
  //                     right: 5,
  //                     bottom: 5,
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           is3DImage = !is3DImage;
  //                         });
  //                       },
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           color: const Color.fromARGB(255, 21, 88, 5),
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Center(
  //                             child: Text(
  //                               is3DImage ? "2D" : "3D",
  //                               style: const TextStyle(color: Colors.white),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             : Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Image.network(
  //                     twoDImage ??
  //                         "https://cdn3.iconfinder.com/data/icons/nft-blockchain-technology-rich-series/256/PFP-512.png",
  //                   ),
  //                 ],
  //               ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(body: Consumer<ProfileProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.profile == null) {
          return Center(
            child: myProccesser(),
          );
        }
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              colorFilter: ColorFilter.mode(
                  // ignore: deprecated_member_use
                  Colors.white.withOpacity(0.2),
                  BlendMode.dstATop),
              image: const AssetImage(
                "assets/images/Pattern.png",
              ),
              fit: kIsWeb ? BoxFit.cover : BoxFit.none,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Semantics(
                            value: "Here Your Profile",
                            //  AppLocalizations.of(context)!.profileTitle,
                            readOnly: true,
                            label: "Profile Page Title'",
                            header: true,
                            hint: 'Profile Page Title',
                            onTapHint: 'Profile Page Title',
                            child: GradientText(
                              "Here Your Profile",
                              // AppLocalizations.of(context)!.profileTitle,
                              // 'Find Your \nFavorite Food',
                              style: GoogleFonts.poppins(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.lightGreen,
                                  AppColors.darkGreen,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Semantics(
                          label: "Notification Button",
                          button: true,
                          hint:
                              'Notification Button to redairect notification page',
                          onTapHint:
                              'Notification Button to redairect notification page',
                          child: GestureDetector(
                            onTap: () {
                              Sentry.addBreadcrumb(
                                Breadcrumb(
                                  message: "User clicked on Shader widget",
                                  level: SentryLevel.info,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade100,
                                      offset: const Offset(5, 25),
                                      blurRadius: 15),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/images/home/notification.png",
                                  height: height / 30,
                                  width: width / 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Semantics(
                      readOnly: true,
                      label: "Profile Image",
                      image: true,
                      hint: "Your Profile Image",
                      child: Center(
                        child: GestureDetector(
                          onTap: _flipCard,
                          child: Center(
                            child: SizedBox(
                              width: 140,
                              height: 140,
                              child: AnimatedBuilder(
                                animation: animationController,
                                builder: (BuildContext context, Widget? child) {
                                  return Transform(
                                    transform: Matrix4.rotationY(
                                        animationController.value * pi),
                                    alignment: Alignment.center,
                                    child:
                                        isFront ? _buildFront() : _buildBack(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    !is3DImage
                        ? kIsWeb
                            ? SizedBox()
                            : Center(
                                child: CustomeButton(
                                  heights: 36,
                                  widths: 180,
                                  name: "View 3D Avatar",
                                  ontap: () {
                                    Sentry.addBreadcrumb(
                                      Breadcrumb(
                                        message:
                                            "User clicked on Local 3D model",
                                        level: SentryLevel.info,
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Local3dModel(
                                          threeDImageUrl: "$threeDImage",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                        : SizedBox(),
                    const SizedBox(height: 10),
                    Center(
                      child: Semantics(
                        readOnly: true,
                        label: "Profile User Name",
                        hint: 'Your Profile User Name',
                        onTapHint: 'Your Profile User Name',
                        child: Text(
                          "${value.profile!.fname} ${value.profile!.lname}",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 300),
                    Center(
                      child: Semantics(
                        readOnly: true,
                        label: "Profile User Email Id",
                        hint: 'Your Profile User Email Id',
                        onTapHint: 'Your Profile User Email Id',
                        child: Text(
                          value.profile!.email!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 25,
                    ),
                    MergeSemantics(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Semantics(
                            label: 'Gift Button',
                            button: true,
                            hint: 'Show the Gifts onpress of gift button',
                            onTapHint: 'Show the Gifts onpress of gift button',
                            child: Focus(
                              onFocusChange: (value) {
                                if (value) {
                                  debugPrint('gift button pressed');
                                }
                              },
                              child: VerticalContainerButton(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SnowFall(),
                                      // builder: (context) => MyPainter(),
                                    ),
                                  );
                                },
                                iconData: Icons.redeem,
                                iconColor: AppColors.darkGreen,
                                text: "Gifts",
                                // AppLocalizations.of(context)!.gifts,
                              ),
                            ),
                          ),
                          Semantics(
                            label: "Favorite Food Items Button",
                            button: true,
                            hint:
                                'Show the Favorite Food items onPress of Favorite button',
                            onTapHint:
                                'Show the Favorite Food items onPress of Favorite button',
                            child: Focus(
                              onFocusChange: (value) {
                                if (value) {
                                  debugPrint("favorite button clicked");
                                }
                              },
                              child: VerticalContainerButton(
                                onTap: () {
                                  Sentry.addBreadcrumb(
                                    Breadcrumb(
                                      message:
                                          "User clicked on Favorite Items.",
                                      level: SentryLevel.info,
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FavoriteItems(),
                                    ),
                                  );
                                },
                                iconData: Icons.favorite,
                                iconColor: Colors.red,
                                text: "Favorites",
                                // AppLocalizations.of(context)!.favorites,
                              ),
                            ),
                          ),
                          Semantics(
                            label: "orders Button",
                            button: true,
                            hint:
                                'Show Your recent food order details onPress of orders button',
                            onTapHint:
                                'Show Your recent food order details onPress of orders button',
                            child: VerticalContainerButton(
                              onTap: () {
                                Sentry.addBreadcrumb(
                                  Breadcrumb(
                                    message: "User clicked on Track Order.",
                                    level: SentryLevel.info,
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrackOrder(),
                                  ),
                                );
                              },
                              iconData: Icons.shopping_bag,
                              iconColor: Colors.blue,
                              text: "Orders",
                              // AppLocalizations.of(context)!.orders,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 60),
                    Semantics(
                      label: "My Profile Button",
                      button: true,
                      hint:
                          'Show & Edit your profile details onPress of my profile button',
                      onTapHint:
                          'Show & Edit your profile details onPress of my profile button',
                      child: ContainerButton(
                        height: height,
                        width: width,
                        onTap: () {
                          Sentry.addBreadcrumb(
                            Breadcrumb(
                              message: "User clicked on My Profile.",
                              level: SentryLevel.info,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdateProfile(),
                            ),
                          );
                        },
                        icons: Icons.person,
                        name: "My Profile",
                        // AppLocalizations.of(context)!.myProfile,
                        colors: AppColors.darkGreen,
                      ),
                    ),
                    SizedBox(height: height / 80),
                    GestureDetector(
                      onTap: () {
                        Sentry.addBreadcrumb(
                          Breadcrumb(
                            message: "User clicked on My 3d Avatar.",
                            level: SentryLevel.info,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => kIsWeb
                                  ? ThreeAvatarErrorHandler()
                                  : My3dAvatar()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height / 50, horizontal: width / 60),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.cube,
                                size: height / 40,
                                color: AppColors.darkGreen,
                              ),
                              SizedBox(
                                width: width / 30,
                              ),
                              Text(
                                "3D Avatar",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                CupertinoIcons.right_chevron,
                                size: height / 50,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 80),
                    Semantics(
                      label: "setting Button",
                      button: true,
                      hint:
                          'manage your application settings onPress of settings button',
                      onTapHint:
                          'manage your application settings onPress of settings button',
                      child: ContainerButton(
                        height: height,
                        width: width,
                        onTap: () {
                          Sentry.addBreadcrumb(
                            Breadcrumb(
                              message: "User clicked on Setting Screen.",
                              level: SentryLevel.info,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingScreen(),
                            ),
                          );
                        },
                        icons: Icons.settings,
                        name: "Settings",
                        // AppLocalizations.of(context)!.setting,
                        colors: AppColors.darkGreen,
                      ),
                    ),
                    SizedBox(height: height / 80),
                    Semantics(
                      label: "help and support Button",
                      button: true,
                      hint:
                          'you can find your answers here onPress of logout button',
                      onTapHint:
                          'you can find your answers here onPress of logout button',
                      child: ContainerButton(
                        height: height,
                        width: width,
                        onTap: () {
                          Sentry.addBreadcrumb(
                            Breadcrumb(
                              message:
                                  "User clicked on Help and Support Screen.",
                              level: SentryLevel.info,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HelpAndSupportScreen()),
                          );
                        },
                        icons: Icons.help_rounded,
                        name: "Help & Support",
                        //  AppLocalizations.of(context)!.help,
                        colors: AppColors.darkGreen,
                      ),
                    ),
                    SizedBox(height: height / 80),
                    Semantics(
                      label: "setting Button",
                      button: true,
                      hint:
                          'manage your application settings onPress of settings button',
                      onTapHint:
                          'manage your application settings onPress of settings button',
                      child: ContainerButton(
                        height: height,
                        width: width,
                        onTap: () {
                          Sentry.addBreadcrumb(
                            Breadcrumb(
                              message: "User clicked on Setting Screen.",
                              level: SentryLevel.info,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyPage(),
                            ),
                          );
                        },
                        icons: Icons.privacy_tip,
                        name: "Privacy & Policy",
                        // AppLocalizations.of(context)!.setting,
                        colors: AppColors.darkGreen,
                      ),
                    ),
                    SizedBox(height: height / 80),
                    Semantics(
                      label: "setting Button",
                      button: true,
                      hint:
                          'manage your application settings onPress of settings button',
                      onTapHint:
                          'manage your application settings onPress of settings button',
                      child: ContainerButton(
                        height: height,
                        width: width,
                        onTap: () {
                          Sentry.addBreadcrumb(
                            Breadcrumb(
                              message: "User clicked on Setting Screen.",
                              level: SentryLevel.info,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsPage(),
                            ),
                          );
                        },
                        icons: Icons.description,
                        name: "Terms & Conditions",
                        // AppLocalizations.of(context)!.setting,
                        colors: AppColors.darkGreen,
                      ),
                    ),
                    SizedBox(height: height / 80),
                    Semantics(
                      label: "log out Button  ",
                      button: true,
                      hint:
                          'you can log out to application onPress of logout button',
                      onTapHint:
                          'you can log out to application onPress of logout button',
                      child: ContainerButton(
                        height: height,
                        width: width,
                        onTap: () {
                          Sentry.addBreadcrumb(
                            Breadcrumb(
                              message: "User clicked on Logout.",
                              level: SentryLevel.info,
                            ),
                          );
                          Provider.of<AuthProviders>(context, listen: false)
                              .logout();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        icons: Icons.logout,
                        name: "Log Out",
                        // AppLocalizations.of(context)!.logOut,
                        colors: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
