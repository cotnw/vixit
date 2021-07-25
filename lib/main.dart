import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/home.dart';
import 'screens/map.dart';
import 'screens/navigator.dart';
import 'screens/verification.dart';
import 'screens/shop.dart';
import 'screens/profile.dart';
import 'screens/leaderboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vixit',
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: Welcome.id,
      routes: {
        Home.id: (context) => Home(),
        Map.id: (context) => const Map(),
        Navigation.id: (context) => Navigation(),
        Welcome.id: (context) => Welcome(),
        Verification.id: (context) => Verification(),
        Shop.id: (context) => Shop(),
        Profile.id: (context) => Profile(),
        Leaderboard.id: (context) => Leaderboard(),
      },
    );
  }
}
