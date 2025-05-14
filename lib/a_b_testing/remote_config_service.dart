// import 'package:firebase_remote_config/firebase_remote_config.dart';

// class RemoteConfigService {
//   final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

//   Future<void> initialize() async {
//     await _remoteConfig.setConfigSettings(RemoteConfigSettings(
//       fetchTimeout: const Duration(seconds: 10),
//       minimumFetchInterval: const Duration(seconds: 0),
//     ));

//     await _remoteConfig.fetchAndActivate();
//   }

//   String getExploreButtonText() {
//     return _remoteConfig.getString('explore_button_text');
//   }
// }

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(seconds: 0),
    ));

    await _remoteConfig.fetchAndActivate();
  }

  String getExploreButtonText() {
    return _remoteConfig.getString("explore_button_text");
  }
}
