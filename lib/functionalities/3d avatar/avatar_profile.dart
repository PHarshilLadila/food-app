// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:o3d/o3d.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AvatarProfile extends StatefulWidget {
  final ProfileData data;
  const AvatarProfile({
    super.key,
    required this.data,
  });

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  late final WebViewController webViewController;
  final O3DController controller = O3DController();

  final api = 'https://api.readyplayer.me/v1/avatars/';
  bool isThreeD = false;
  int idx = 0;
  late String twoDUrl;

  @override
  initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).profile;
      Provider.of<ProfileProvider>(context, listen: false).getUserData();
      setState(() {});
    });

    var avatarIdAPI = widget.data.avatarId;
    twoDUrl = '$api$avatarIdAPI.png';

    debugPrint("THIS IS THE 2D IMAGE URL : $twoDUrl");
    // storeAvatarImagePath(twoDUrl, "${widget.data.avatarUrl}");
    store2DImagePath(twoDUrl, "${widget.data.avatarUrl}");
  }

  // storeAvatarImagePath(String twoDPath, String threeDPath) async {
  //   final FlutterSecureStorage storage = const FlutterSecureStorage();

  //   var finalTwoDImagePath =
  //       await storage.write(key: "FinalTwoDImagePath", value: twoDPath);
  //   var finalThreeDImagePath =
  //       await storage.write(key: "finalThreeDImagePath", value: threeDPath);

  //   debugPrint(
  //       "THIS IS THE FINAL 2D IMAGE PATH FROM SECURE STORAGE ::: ::: ::: ${finalTwoDImagePath as String}");
  //   debugPrint(
  //       "THIS IS THE FINAL 3D IMAGE PATH FROM SECURE STORAGE ::: ::: ::: ${finalThreeDImagePath as String}");
  // }

  store2DImagePath(String twoDPath, String threeDPath) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("FinalTwoDImagePath", twoDPath);
    preferences.setString("finalThreeDImagePath", threeDPath);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomScreen()),
                );
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 20,
              child: ToggleSwitch(
                initialLabelIndex: idx,
                labels: const ['2D', '3D'],
                totalSwitches: 2,
                customWidths: const [50, 50],
                borderWidth: 0.5,
                activeBgColor: const [Colors.green],
                inactiveBgColor: Colors.white30,
                borderColor: const [Colors.black],
                onToggle: (index) {
                  setState(() {
                    idx = index ?? 0;
                    isThreeD = index == 1;
                  });
                },
              ),
            ),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (isThreeD)
            SizedBox(
              height: 400,
              width: 500,
              child: O3D(
                controller: controller,
                progressBarColor: Colors.red,
                src: '${widget.data.avatarUrl}',
                alt: "3D Model of Avatar",
                autoRotate: true,
                cameraControls: true,
                backgroundColor: const Color.fromARGB(179, 245, 255, 246),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                alignment: Alignment.center,
                twoDUrl,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
      bottomSheet: Consumer<ProfileProvider>(
        builder: (BuildContext context, ProfileProvider value, Widget? child) {
          return BottomSheet(
            backgroundColor: Colors.white,
            showDragHandle: true,
            enableDrag: false,
            dragHandleColor: Colors.blueGrey,
            onClosing: () {},
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height / 4.5,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text:
                            '${value.profile!.fname ?? 'N/A'} ${value.profile!.lname ?? "N/A"} ',
                        style: GoogleFonts.bungeeInline(
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(
                            text: "@${value.profile!.name}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      value.profile!.email ?? "example@gmail.com",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                        children: [
                          TextSpan(
                            text: 'Heyy.. ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${value.profile!.fname ?? 'N/A'} ${value.profile!.lname ?? "N/A"}, ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Your 2D & 3D avatar is ready to use in your profile.\n",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text:
                                "• The 2D image is automatically set as your profile picture.\n",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          TextSpan(
                            text:
                                "• You can also select your 3D Avarat on profile picture. Enjoy it ",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          TextSpan(
                            text: "🎉",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: CustomeButton(
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomScreen(),
            ),
          );
        },
        name: "Done",
        heights: 40,
        widths: width / 6,
      ),
    );
  }
}
