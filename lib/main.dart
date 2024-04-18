import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/mozart_app.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:mozart_flutter_app/utils/constants/bloc_observer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/dio-helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  // await GeocodingPlatform.instance.;
  var preferences = await SharedPreferences.getInstance();
  preferences.remove('myLocation');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await MyCache.init();
  DioHelper2.init();
  runApp(
    ChangeNotifierProvider(
      child: MozartApp(),
      create: (BuildContext context) {
        return AppProvider();
      },
    ),
  );
//   runApp(
//     MaterialApp(
//       home: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Location Details',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Search(),
//     );
  }
