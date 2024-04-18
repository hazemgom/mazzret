import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';

class AppProvider extends ChangeNotifier {
  String appLanguage = MyCache.getString(key: CacheKeys.lang) == ''
      ? 'ar'
      : MyCache.getString(key: CacheKeys.lang) ?? 'ar';

  void changeAppLanguage(String languageCode) {
    appLanguage = languageCode;
    MyCache.putString(key: CacheKeys.lang, value: languageCode);
    notifyListeners();
  }
}
