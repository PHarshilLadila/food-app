// import 'package:flutter/material.dart';
// import 'package:http_certificate_pinning/http_certificate_pinning.dart';

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _PiningSslData {
//   String serverURL = '';
//   Map<String, String> headerHttp = {};
//   String allowedSHAFingerprint = '';
//   int timeout = 0;
//   SHA? sha;
// }

// class _MyAppState extends State<MyApp> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final _PiningSslData _data = _PiningSslData();
//   BuildContext? scaffoldContext;

//   @override
//   initState() {
//     super.initState();
//   }

//   void check(String url, String fingerprint, SHA sha,
//       Map<String, String> headerHttp, int timeout) async {
//     List<String> allowedShA1FingerprintList = [];
//     allowedShA1FingerprintList.add(fingerprint);

//     try {
//       String checkMsg = await HttpCertificatePinning.check(
//         serverURL: url,
//         headerHttp: headerHttp,
//         sha: sha,
//         allowedSHAFingerprints: allowedShA1FingerprintList,
//         timeout: timeout,
//       );

//       debugPrint("checkMsg: $checkMsg");
//       if (!mounted) return;
//       debugPrint("checkMsg: $checkMsg");
//       if (checkMsg == "CONNECTION_SECURE") {
//         checkMsg = "Connection is secure";
//       } else if (checkMsg == "CONNECTION_NOT_SECURE") {
//         checkMsg = "Connection is not secure";
//       } else {
//         checkMsg = "Connection is not secure";
//       }
//     } catch (e) {
//       debugPrint("Error: $e");
//     }
//   }

//   void submit() {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();

//       check(_data.serverURL, _data.allowedSHAFingerprint, _data.sha!,
//           _data.headerHttp, _data.timeout);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     scaffoldContext = context;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Ssl Pinning Plugin'),
//         ),
//         body: Builder(
//           builder: (BuildContext context) {
//             scaffoldContext = context;
//             return Form(
//               key: formKey,
//               child: ListView(
//                 shrinkWrap: true,
//                 children: <Widget>[
//                   TextFormField(
//                       keyboardType: TextInputType.url,
//                       decoration: InputDecoration(
//                           hintText: 'https://yourdomain.com', labelText: 'URL'),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter some url';
//                         }
//                         return null;
//                       },
//                       onSaved: (String? value) {
//                         _data.serverURL = value!;
//                       }),
//                   DropdownButton(
//                     items: [
//                       DropdownMenuItem(
//                         value: SHA.SHA1,
//                         child: Text(SHA.SHA1.toString()),
//                       ),
//                       DropdownMenuItem(
//                         value: SHA.SHA256,
//                         child: Text(SHA.SHA256.toString()),
//                       )
//                     ],
//                     value: _data.sha,
//                     isExpanded: true,
//                     onChanged: (SHA? val) {
//                       setState(
//                         () {
//                           _data.sha = val;
//                         },
//                       );
//                     },
//                   ),
//                   TextFormField(
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                           hintText: 'OO OO OO OO OO OO OO OO OO OO',
//                           labelText: 'Fingerprint'),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter some fingerprint';
//                         }
//                         return null;
//                       },
//                       onSaved: (String? value) {
//                         _data.allowedSHAFingerprint = value!;
//                       }),
//                   TextFormField(
//                     keyboardType: TextInputType.number,
//                     initialValue: '60',
//                     decoration:
//                         InputDecoration(hintText: '60', labelText: 'Timeout'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter some timeout';
//                       }
//                       return null;
//                     },
//                     onSaved: (String? value) {
//                       _data.timeout = int.parse(value!);
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
