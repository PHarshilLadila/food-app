import 'package:flutter/widgets.dart';
import 'package:food_app/a_b_testing/remote_config_service.dart';

class AbProvider with ChangeNotifier {
  final RemoteConfigService remoteConfigService = RemoteConfigService();
  String _buttonLabel = "Explore Foods"; // fallback

  String get buttonLabel => _buttonLabel;
  Future<void> loadRemoteValues() async {
    await remoteConfigService.initialize();
    _buttonLabel = remoteConfigService.getExploreButtonText();
    notifyListeners();
  }
}
