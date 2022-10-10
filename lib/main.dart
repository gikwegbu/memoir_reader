import 'package:flutter/material.dart';
import 'package:memoir_reader/modules/dashboard/dashboard_screen.dart';
import 'package:memoir_reader/utils/const/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memoir Reader',
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
      home: const Dashboard(),
    );
  }
}


//  inputDecorationTheme: const InputDecorationTheme(
//     textTheme:
//         TextTheme(
//       subtitle1: TextStyle(color: Colors.pinkAccent), //<-- SEE HERE
//     ),