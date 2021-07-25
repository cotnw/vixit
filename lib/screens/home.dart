import 'package:flutter/material.dart';
import 'package:vixit/screens/leaderboard.dart';
import './map.dart';
import './verification.dart';
import './shop.dart';
import './profile.dart';

class Home extends StatefulWidget {
  static String id = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Image.network(
                  "https://cdn.discordapp.com/attachments/867295602453905448/868884970742099978/unknown.png"),
              onPressed: () {
                Navigator.pushNamed(context, Leaderboard.id);
              },
              iconSize: 20,
              padding: EdgeInsets.only(left: 10, top: 20, bottom: 0),
            ), // you can put Icon as well, it accepts any widget.
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 0),
                    child: Center(
                      child: Text("Vixit",
                          style: TextStyle(
                              fontFamily: 'Antipasto',
                              fontSize: 30,
                              color: Color(0xff212135))),
                    ))
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Profile.id);
                },
                icon: Image.network(
                    'https://cdn.discordapp.com/attachments/867295602453905448/868885529503092766/unknown.png'),
                iconSize: 45,
                padding: EdgeInsets.only(top: 15, bottom: 0, right: 20),
              ),
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Map.id);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 5, 10, 0),
                child: Image.network(
                    'https://cdn.discordapp.com/attachments/867295602453905448/868892074483785778/unknown.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Verification.id);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 10, 10),
                margin: EdgeInsets.only(bottom: 0),
                child: Image.network(
                    'https://cdn.discordapp.com/attachments/867295602453905448/868901711601868831/Group_177.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Shop.id);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 10, 10),
                margin: EdgeInsets.only(bottom: 0),
                child: Image.network(
                    'https://cdn.discordapp.com/attachments/867295602453905448/868890631177654302/unknown.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
