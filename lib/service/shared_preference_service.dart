import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static String changKey = 'chang_key';
  static String studentKey = 'std_key';

  static Future setChang(bool isList) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setBool(changKey, isList);
  }

  static Future<bool> getChange() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    bool value = sf.getBool(changKey) ?? true;
    return value;
  }
}
