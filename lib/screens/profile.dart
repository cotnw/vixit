import 'package:flutter/material.dart';
import './leaderboard.dart';

class Profile extends StatefulWidget {
  static String id = "profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.discordapp.com/attachments/746672699144798310/868911133942251530/unknown.png"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
