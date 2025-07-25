// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/functionalities/profile/model/profile_model.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:hive_flutter/adapters.dart';

// class AuthProviders extends ChangeNotifier {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   User? googleUser;
//   ProfileModel? _user;
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   void setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   ProfileModel? get user => _user;
//   User? get gUser => googleUser;
//   set gUser(User? user) => googleUser = user;

//   AuthProviders() {
//     auth.authStateChanges().listen(onAuthStateChanged);
//   }

//   Future<void> login(String email, String password) async {
//     try {
//       UserCredential result = await auth.signInWithEmailAndPassword(
//           email: email, password: password);

//       DocumentSnapshot snapshot =
//           await firestore.collection("users").doc(result.user!.uid).get();

//       if (snapshot.exists) {
//         _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
//       }

//       final databaseBox = Hive.box('userProfile');
//       await databaseBox.put('userid', result.user!.uid);

//       notifyListeners();
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   Future<void> register(String email, String password, String userName) async {
//     try {
//       UserCredential result = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);

//       _user = ProfileModel(
//           uid: result.user!.uid, email: result.user!.email, name: userName);

//       await firestore
//           .collection("users")
//           .doc(result.user!.uid)
//           .set(_user!.toMap());

//       final databaseBox = Hive.box('userProfile');
//       await databaseBox.put('userid', result.user!.uid);

//       notifyListeners();
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   Future<void> updateUserData(Map<String, dynamic> data) async {
//     if (_user != null) {
//       await firestore.collection("users").doc(_user!.uid).update(data);
//       _user = ProfileModel.fromMap({..._user!.toMap(), ...data});
//       notifyListeners();
//     }
//   }

//   Future<void> updateProfilePicture() async {}

//   Future<void> addUserDetails(
//       String fName, String lName, String mobileNo) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'fname': fName,
//         'lname': lName,
//         "mobile": mobileNo,
//       },
//     );
//   }

//   Future<void> updateName(
//     String name,
//   ) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'name': name,
//       },
//     );
//   }

//   Future<void> updateEmail(
//     String email,
//   ) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'email': email,
//       },
//     );
//   }

//   Future<void> updateFname(
//     String fname,
//   ) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'fname': fname,
//       },
//     );
//   }

//   Future<void> updateLname(
//     String lName,
//   ) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'lname': lName,
//       },
//     );
//   }

//   Future<void> updateMobile(
//     String mobile,
//   ) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'mobile': mobile,
//       },
//     );
//   }

//   Future<void> updateLocation(
//     String location,
//   ) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'location': location,
//       },
//     );
//   }

//   // Future<void> updateUserDetails(
//   //   String name,
//   //   String email,
//   //   String fname,
//   //   String lname,
//   //   String mobile,
//   //   String location,
//   // ) async {
//   //   await firestore.collection("users").doc(user!.uid).update(
//   //     {
//   //       'name': name,
//   //       'email': email,
//   //       'fname': fname,
//   //       'lname': lname,
//   //       'mobile': mobile,
//   //       'location': location,
//   //     },
//   //   );
//   // }

//   Future<void> addImageProfile(String imageUrl) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'profileImage': imageUrl,
//       },
//     );
//   }

//   Future<void> addCurrentLocation(String currentUserAddress) async {
//     await firestore.collection("users").doc(user!.uid).update(
//       {
//         'location': currentUserAddress,
//       },
//     );
//   }

//   Future<bool> signInWithGoogle(BuildContext context) async {
//     try {
//       final googleSignInAccount = await googleSignIn.signIn();
//       if (googleSignInAccount == null) {
//         return false;
//       }

//       final googleAuth = await googleSignInAccount.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final authResult = await auth.signInWithCredential(credential);
//       gUser = authResult.user;

//       DocumentSnapshot snapshot =
//           await firestore.collection("users").doc(authResult.user!.uid).get();

//       if (snapshot.exists) {
//         _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
//       } else {
//         _user = ProfileModel(
//           uid: authResult.user!.uid,
//           name: authResult.user!.displayName,
//           email: authResult.user!.email,
//         );
//         await firestore
//             .collection("users")
//             .doc(authResult.user!.uid)
//             .set(_user!.toMap());
//       }

//       notifyListeners();
//       return true;
//     } on FirebaseAuthException catch (e) {
//       debugPrint("Google Sign-In Error: ${e.message}");
//       return false;
//     }
//   }

//   Future<void> logout() async {
//     Box? boxData = Hive.box("userProfile");
//     var userUid = boxData.get("userid");

//     if (gUser != null) {
//       await googleSignIn.signOut();
//       await boxData.clear();

//       gUser = null;
//     } else if (_user != null) {
//       await auth.signOut();
//       _user = null;
//       await boxData.clear();
//       await boxData.delete("userid");
//     } else if (userUid != null) {
//       await boxData.clear();
//       await boxData.delete("userid");
//       boxData = null;
//     }
//     notifyListeners();
//   }

//   void onAuthStateChanged(User? firebaseUser) async {
//     if (firebaseUser == null) {
//       _user = null;
//       googleUser = null;
//     } else {
//       DocumentSnapshot snapshot =
//           await firestore.collection("users").doc(firebaseUser.uid).get();
//       if (snapshot.exists) {
//         _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
//       }
//       googleUser = firebaseUser;
//     }
//     notifyListeners();
//   }
// }

// extension on ProfileModel {
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'email': email,
//       'fname': fname,
//       'lname': lname,
//       'location': location,
//       'mobile': mobile,
//       'name': name,
//       'profileImage': profileImage,
//     };
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_app/functionalities/profile/model/profile_model.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class AuthProviders extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? googleUser;
  ProfileModel? _user;
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  ProfileModel? get user => _user;
  User? get gUser => googleUser;
  set gUser(User? user) => googleUser = user;

  AuthProviders() {
    auth.authStateChanges().listen(onAuthStateChanged);
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(result.user!.uid).get();

      if (snapshot.exists) {
        _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }

      final databaseBox = Hive.box('userProfile');
      await databaseBox.put('userid', result.user!.uid);

      notifyListeners();
    } on FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is incorrect.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "This user account has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many attempts. Please try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Email/password login is not enabled.";
          break;
        default:
          errorMessage = "An unexpected error occurred. Please try again.";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("Something went wrong. Please try again.");
    }
  }

  Future<void> register(String email, String password, String userName) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _user = ProfileModel(
          uid: result.user!.uid, email: result.user!.email, name: userName);

      await firestore
          .collection("users")
          .doc(result.user!.uid)
          .set(_user!.toMap());

      final databaseBox = Hive.box('userProfile');
      await databaseBox.put('userid', result.user!.uid);

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        appTostMessage(
          context as BuildContext,
          ToastificationType.error,
          "The password provided is too weak.",
          "assets/images/wronge.png",
        );
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        appTostMessage(
          context as BuildContext,
          ToastificationType.error,
          "The account already exists for that email.",
          "assets/images/wronge.png",
        );
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return false;
      }

      final googleAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await auth.signInWithCredential(credential);
      gUser = authResult.user;

      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(authResult.user!.uid).get();

      await preferences.setString("googleAuthUID", authResult.user!.uid);

      if (snapshot.exists) {
        _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        _user = ProfileModel(
          uid: authResult.user!.uid,
          name: authResult.user!.displayName,
          email: authResult.user!.email,
        );
        await firestore
            .collection("users")
            .doc(authResult.user!.uid)
            .set(_user!.toMap());
      }

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("Google Sign-In Error: ${e.message}");
      return false;
    }
  }

  // Future<bool> signInWithFacebook(BuildContext context) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   try {
  //     final LoginResult loginResult;

  //     if (kIsWeb) {
  //       loginResult = await FacebookAuth.instance.login(
  //         permissions: ['email', 'public_profile'],
  //       );
  //     } else {
  //       loginResult = await FacebookAuth.instance.login();
  //     }

  //     debugPrint("Login Status: ${loginResult.status}");

  //     if (loginResult.status == LoginStatus.success) {
  //       final accessToken = loginResult.accessToken!;
  //       final credential =
  //           FacebookAuthProvider.credential(accessToken.tokenString);

  //       final authResult = await auth.signInWithCredential(credential);
  //       gUser = authResult.user;

  //       final userData = await FacebookAuth.instance.getUserData(
  //         fields: "email,name,picture.width(200)",
  //       );

  //       final doc = firestore.collection("users").doc(gUser!.uid);
  //       final snapshot = await doc.get();

  //       await preferences.setString("facebookUID", gUser!.uid);

  //       if (snapshot.exists) {
  //         _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
  //       } else {
  //         _user = ProfileModel(
  //           uid: gUser!.uid,
  //           name: userData['name'] ?? '',
  //           email: userData['email'] ?? '',
  //           profileImage: userData["picture"]["data"]["url"] ?? '',
  //         );
  //         await doc.set(_user!.toMap());
  //       }

  //       notifyListeners();
  //       return true;
  //     } else {
  //       debugPrint("Facebook login failed: ${loginResult.message}");
  //       return false;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint("FirebaseAuthException: ${e.message}");
  //     return false;
  //   } catch (e, st) {
  //     debugPrint("Exception: $e");
  //     debugPrint("StackTrace: $st");
  //     return false;
  //   }
  // }

  Future<bool> signInWithFacebook() async {
    print('Facebook Login ======');
    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      "public_profile",
      "email"
    ]); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      print("=====> FB ${result.accessToken}");

      // get the user data
      // by default we get the userId, email,name and picture
      var userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email");
      print('User Profile --->}');
      print('User Profile ---> ${userData.toString()}');
      print('User Profile ---> ${userData['email']}');
      print('User Profile ---> ${userData.length}');
      //Todo: savingData Locally

      userData = userData;
      return true;
    } else {
      print(result.status);
      print(result.message);
      return false;
    }
  }

  // Future<bool> signInWithFacebook(BuildContext context) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login(
  //         // permissions: ['email', 'public_profile'],
  //         );

  //     if (loginResult.status == LoginStatus.success) {
  //       final OAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential(
  //               loginResult.accessToken!.tokenString);

  //       final authResult =
  //           await auth.signInWithCredential(facebookAuthCredential);

  //       gUser = authResult.user;

  //       final userData = await FacebookAuth.instance.getUserData(
  //         fields: "email,name,picture.width(200)",
  //       );

  //       DocumentSnapshot snapshot =
  //           await firestore.collection("users").doc(gUser!.uid).get();

  //       await preferences.setString("facebookUID", gUser!.uid);

  //       if (snapshot.exists) {
  //         _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
  //       } else {
  //         _user = ProfileModel(
  //           uid: gUser!.uid,
  //           name: userData['name'] ?? '',
  //           email: userData['email'] ?? '',
  //           profileImage: userData["picture"]["data"]["url"] ?? '',
  //         );

  //         await firestore
  //             .collection("users")
  //             .doc(gUser!.uid)
  //             .set(_user!.toMap());
  //       }

  //       notifyListeners();
  //       return true;
  //     } else {
  //       debugPrint("Facebook login failed: ${loginResult.message}");
  //       return false;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint("Facebook Sign-In Firebase Error: ${e.message}");
  //     return false;
  //   } catch (e, stackTrace) {
  //     debugPrint("Facebook Login Error: $e");
  //     debugPrint("StackTrace: $stackTrace");
  //     debugPrint("Facebook Login Error: $e");
  //     return false;
  //   }
  // }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    if (_user != null) {
      await firestore.collection("users").doc(_user!.uid).update(data);
      _user = ProfileModel.fromMap({..._user!.toMap(), ...data});
      notifyListeners();
    }
  }

  Future<void> updateProfilePicture() async {}

  Future<void> addUserDetails(
      String fName, String lName, String mobileNo) async {
    if (googleUser != null) {
      await firestore.collection("users").doc(googleUser!.uid).update(
        {
          'fname': fName,
          'lname': lName,
          "mobile": mobileNo,
        },
      );
    }
  }

  Future<void> updateName(
    String name,
  ) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'name': name,
      },
    );
  }

  Future<void> updateEmail(
    String email,
  ) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'email': email,
      },
    );
  }

  Future<void> updateFname(
    String fname,
  ) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'fname': fname,
      },
    );
  }

  Future<void> updateLname(
    String lName,
  ) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'lname': lName,
      },
    );
  }

  Future<void> updateMobile(
    String mobile,
  ) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'mobile': mobile,
      },
    );
  }

  Future<void> updateLocation(
    String location,
  ) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'location': location,
      },
    );
  }

  Future<void> forgotPassword(String emailAddress) async {
    try {
      await auth.sendPasswordResetEmail(email: emailAddress);
    } on FirebaseAuthException catch (e) {
      debugPrint("Google Sign-In Error: ${e.message}");
    }
  }

  Future<void> addImageProfile(String imageUrl) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'profileImage': imageUrl,
      },
    );
  }

  Future<void> addCurrentLocation(String currentUserAddress) async {
    await firestore.collection("users").doc(user!.uid).update(
      {
        'location': currentUserAddress,
      },
    );
  }

  Future<void> logout() async {
    Box? boxData = Hive.box("userProfile");
    var userUid = boxData.get("userid");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.get("FinalTwoDImagePath");
    preferences.get("finalThreeDImagePath");

    if (gUser != null) {
      await googleSignIn.signOut();
      await boxData.clear();
      await preferences.remove("FinalTwoDImagePath");
      await preferences.remove("finalThreeDImagePath");
      await preferences.clear();

      gUser = null;
    } else if (_user != null) {
      await auth.signOut();
      _user = null;
      await boxData.clear();
      await preferences.remove("FinalTwoDImagePath");
      await preferences.remove("finalThreeDImagePath");
      await preferences.clear();
      await boxData.delete("userid");
    } else if (userUid != null) {
      await boxData.clear();
      await boxData.delete("userid");
      boxData = null;
      await preferences.remove("FinalTwoDImagePath");
      await preferences.remove("finalThreeDImagePath");
      await preferences.clear();
    }
    notifyListeners();
  }

  void onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
      googleUser = null;
    } else {
      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(firebaseUser.uid).get();
      if (snapshot.exists) {
        _user = ProfileModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      googleUser = firebaseUser;
    }
    notifyListeners();
  }
}

extension on ProfileModel {
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fname': fname,
      'lname': lname,
      'location': location,
      'mobile': mobile,
      'name': name,
      'profileImage': profileImage,
    };
  }
}
