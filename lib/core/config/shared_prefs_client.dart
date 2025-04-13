import 'package:shared_preferences/shared_preferences.dart';

import 'shared_prefs_keys.dart';

class SharedPrefsClient {
  final SharedPreferences _prefs;

  SharedPrefsClient(this._prefs);
  set email(String value) => _prefs.setString(kEmailKey, value);

  String get email => _prefs.getString(kEmailKey) ?? "";
}
