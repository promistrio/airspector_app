import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'pages/missions/mission_page.dart';
import 'business_logic/providers/mission_provider.dart';
import 'package:airspector/business_logic/controllers/mission_edit_controller.dart';
import 'pages/missions/mission_from_file_page.dart';

void main() {
  MissionEditController missionController = MissionEditController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                MissionProvider(missionController: missionController)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        //brightness: Brightness.dark,
        primaryColor: const Color(0xFF3F51B5),
        appBarTheme: const AppBarTheme(color: Color(0xFF3F51B5)),

        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
      home: MissionFromFilePage(),
    );
  }
}
