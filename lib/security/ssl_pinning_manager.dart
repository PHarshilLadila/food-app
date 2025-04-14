import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:http/io_client.dart';

class SSlPinningManager {
  Future<void> initialize() async {
    var client = await _getSSLclient();
    BaseClient(client);
  }

  Future<SecurityContext?> get _securityContect async {
    final data =
        await rootBundle.load("assets/certificates/hot_coffee_sampleapis.pem");
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());
    return context;
  }

  Future<IOClient> _getSSLclient() async {
    HttpClient client = HttpClient(context: await _securityContect);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}

class BaseClient {
  static const int timeOutDutration = 60;
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Accept-Language": "en-US",
  };

  BaseClient._internal();
  static final BaseClient _instance = BaseClient._internal();
  static BaseClient get instance => _instance;
  late final http.Client client;
  late final SSlPinningManager sslPinningManager;
  factory BaseClient(http.Client client) {
    _instance.client = client;
    return _instance;
  }

  Future<dynamic> getdetailss(String api) async {
    var uri = Uri.parse("https://api.sampleapis.com/coffee/hot");
    debugPrint(uri.toString());
    try {
      var response = await client
          .get(
            uri,
            headers: headers,
          )
          .timeout(const Duration(seconds: timeOutDutration));
      if (response.statusCode == 200) {
        return response;
      } else {
        debugPrint("Error on get request : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error on get request : $e");
      return null;
    }
  }
}
