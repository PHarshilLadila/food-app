import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/functionalities/profile/model/profile_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? _profile;

  ProfileModel? get profile => _profile;

  ProfileProvider();

  Future<void> getUserData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var data = await preferences.getString("googleAuthUID");

      log("THIS IS GOOGLE AUTH USER ID :: $data");

      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (snapshot.exists) {
        _profile =
            ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
        notifyListeners();
      }
      throw StateError('Error on fetching user data..!');
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      debugPrint("Error fetching user data: $exception");
    }
  }
}
