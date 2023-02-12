import 'package:get_storage/get_storage.dart';
import 'caching_keys.dart';

class PreferenceManager {
  void saveLoginStatus(bool loginStatus) => GetStorage().write(CachingKey.IS_LOGGED_IN, loginStatus);

  bool isLoggedIn() => GetStorage().read(CachingKey.IS_LOGGED_IN) as bool? ?? false;

  void saveAuthToken(String authToken) => GetStorage().write(CachingKey.AUTH_TOKEN, "Bearer $authToken");


  String authToken() => GetStorage().read(CachingKey.AUTH_TOKEN) as String? ?? "";

  // void saveFCMToken(String fcmToken)=>GetStorage().write(CachingKey.FCM_TOKEN, fcmToken);
  void saveLanguage(String lang) => GetStorage().write(CachingKey.LANGUAGE, lang);

  // String fcmToken()=>GetStorage().read(CachingKey.FCM_TOKEN) as String ??"TEST_TOKEN";

  String currentLang() => GetStorage().read(CachingKey.LANGUAGE) as String? ?? "en";


  void logout() {

    GetStorage().erase();
  }
}
