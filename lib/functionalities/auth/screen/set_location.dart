import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/auth/screen/profile_done.dart';
import 'package:food_app/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  String? currentAddress;
  Position? currentPosition;
  bool isLoading = false;

  Future<void> getCurrentPosition() async {
    setState(() => isLoading = true);
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      setState(() => isLoading = false);
      return;
    }
    try {
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await getAddressFromLatLng(currentPosition!);
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() => isLoading = false);
  }

  String buildAddress(Placemark place) {
    final parts = [
      place.subThoroughfare,
      place.thoroughfare,
      place.subLocality,
      place.locality,
      place.subAdministrativeArea,
      place.administrativeArea,
      place.postalCode,
      place.country,
    ];

    final address = parts
        .where((part) => part != null && part.trim().isNotEmpty)
        .join(', ');

    return address.isNotEmpty ? '$address.' : '';
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      setState(() {
        currentAddress = buildAddress(place);
        // "${place.subThoroughfare ?? ""} - ${place.street}, ${place.name}, ${place.thoroughfare}, ${place.subLocality}, ${place.subAdministrativeArea}${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}.";

        // "${place.subThoroughfare}, ${place.street}, ${place.thoroughfare}, ${place.subLocality} ${place.subAdministrativeArea}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}.";
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(
          // AppLocalizations.of(context)!.locationServiceDisabled
          "Location services are disabled. Please enable the services.");
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(
          // AppLocalizations.of(context)!.locationPermissionDenied
          "Location permissions are denied",
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(
          // AppLocalizations.of(context)!.locationPermissionPermanentlyDenied,
          "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void storeLocation() {
    try {
      Provider.of<AuthProviders>(context, listen: false)
          .addCurrentLocation(currentAddress ?? "Set Your Location");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileDone()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.darkGreen,
          behavior: SnackBarBehavior.floating,
          content: Text("Location added successfully"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      showSnackBar(e.toString());
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
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height * 0.03,
              width: width * 0.8,
              decoration: BoxDecoration(
                color: AppColors.lightOrange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.darkOrange),
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
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            GradientText(
              // AppLocalizations.of(context)!.setYourLocation,
              "Set Your Location",
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.w600),
              gradient: const LinearGradient(
                  colors: [AppColors.blackColor, AppColors.blackColor]),
            ),
            SizedBox(height: height * 0.02),
            GradientText(
              // AppLocalizations.of(context)!.proccessData,
              "This data will be displayed in your account profile for security,",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w400),
              gradient: const LinearGradient(
                  colors: [AppColors.blackColor, AppColors.blackColor]),
            ),
            SizedBox(height: height * 0.03),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 250, 255, 251),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 12,
                      offset: Offset(2, 5),
                      color: Color.fromARGB(255, 219, 219, 219))
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/login/location.png",
                          height: height * 0.05),
                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: isLoading
                            ? myProccesser()
                            : GradientText(
                                currentAddress ??
                                    // AppLocalizations.of(context)!
                                    //     .setYourLocation,
                                    "Set Your Location",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                gradient: const LinearGradient(colors: [
                                  AppColors.blackColor,
                                  AppColors.blackColor
                                ]),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  GestureDetector(
                    onTap: getCurrentPosition,
                    child: Container(
                      width: double.infinity,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.95, 0.0),
                          end: Alignment(1.0, 0.0),
                          colors: [
                            AppColors.lightGreen,
                            AppColors.darkGreen,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          // AppLocalizations.of(context)!.setLocation,
                          "Set Location",
                          style: GoogleFonts.poppins(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: storeLocation,
        child: Container(
          width: width * 0.4,
          height: height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: const LinearGradient(
                begin: Alignment(-0.95, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [Color(0xff53E88B), Color(0xff15BE77)]),
          ),
          child: Center(
            child: Text(
              // AppLocalizations.of(context)!.next,
              "Next",
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
