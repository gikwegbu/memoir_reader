import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir_reader/config/routes.dart';
import 'package:memoir_reader/modules/dashboard/dashboard_screen.dart';
import 'package:memoir_reader/modules/memoir/viewModel/memoir_provider.dart';
import 'package:memoir_reader/modules/profile/model/ai_settings_model.dart';
import 'package:memoir_reader/modules/profile/model/profile_model.dart';
import 'package:memoir_reader/modules/profile/viewModel/ai_settings_provider.dart';
import 'package:memoir_reader/modules/profile/viewModel/profile_provider.dart';
import 'package:memoir_reader/modules/splash_screen.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter('${appDocumentDirectory.path}/hiveDb');
  Hive.registerAdapter<ProfileModel>(ProfileModelAdapter()); // Type 0
  Hive.registerAdapter<AiSettingsModel>(AiSettingsModelAdapter()); // Type 1

  await Hive.openBox<ProfileModel>("profileBox");
  await Hive.openBox<AiSettingsModel>("aiBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AiProvider()),
        ChangeNotifierProvider(create: (_) => MemoirProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Memoir Reader',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          // primaryColor: Colors.red,
          // primaryColorLight: Colors.green,
          // primarySwatch: Colors.blue,
          primarySwatch: CustomColor.kToDark,
          brightness: Brightness.light,
          // theme: ThemeData(
          //   brightness: Brightness.light,
          //   primaryColor: Colors.red,
          // ),
          // darkTheme: ThemeData(
          //   brightness: Brightness.dark,
          // ),
        ),
        darkTheme: ThemeData(
          // scaffoldBackgroundColor: Colors.black,
          // primaryColor: Colors.red,
          // primaryColorDark: Colors.green,
          // primarySwatch: Colors.red,
          primarySwatch: CustomColor.kToDark,
          brightness: Brightness.dark,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: isLight),
          ),
        ),
        home: const Dashboard(), // Start with the splashScreen bro...
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
