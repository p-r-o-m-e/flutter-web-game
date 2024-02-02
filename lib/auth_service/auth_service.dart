import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class AuthService with ChangeNotifier {
  final _log = Logger('AuthService');
  final Map<String, bool> _playerAccessRepo = {
    'justLoggedIn': false,
  };

  void grantPlayerAccess(String key, String reason) {
    if (_playerAccessRepo.containsKey(key)) {
      _playerAccessRepo.update(key, (value) => true);
      _log.info('Granted access to \'$key\' value. Reason : $reason');
      notifyListeners();
    } else {
      throw ArgumentError("Invalid key provided.");
    }
  }

  void revokePlayerAccess(String key, String reason) {
    if (_playerAccessRepo.containsKey(key)) {
      _playerAccessRepo.update(key, (value) => false);
      _log.info('Revoked access to \'$key\' value. Reason : $reason');
      notifyListeners();
    } else {
      throw ArgumentError("Invalid key provided.");
    }
  }

  bool getPlayerAccessBool(String key) {
    if (_playerAccessRepo.containsKey(key)) {
      return _playerAccessRepo[key]!;
    } else {
      throw ArgumentError("Invalid key provided.");
    }
  }
}
