// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class SSLPinning {
  String serverURL = "";
  Map<String, String> headersHttp = {};
  String allowedSHAFingerprint = "";
  int timeOut = 0;
  SHA? sha;
}

Future<void> checkSSl(String requestURL) async {
  bool checked = false;
  String fingerPrint = "";
  List<String> allowedSHAFingerprintList = [];
  Map<String, String> headerHttp = {};
  allowedSHAFingerprintList.add(fingerPrint);
  try {
    await HttpCertificatePinning.check(
      serverURL: requestURL,
      headerHttp: headerHttp,
      sha: SHA.SHA1, // Use the appropriate SHA enum value
      allowedSHAFingerprints: allowedSHAFingerprintList,
      timeout: 60,
    ).then(
      (value) => () {
        if (value == "CONNECTION_SECURE") {
          checked = true;
        } else if (value == "CONNECTION_NOT_SECURE") {
          checked = false;
        } else {
          checked = false;
        }
      },
    );
  } catch (e) {
    debugPrint("Error: $e");
    checked = false;
  }
}
