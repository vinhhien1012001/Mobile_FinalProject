import 'package:final_project_mobile/components/custom_app_bar.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      navigatorKey: Routes.mainNavigatorKey,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: const HomePage(),
      ),
    );
  }
}
