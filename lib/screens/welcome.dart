import 'package:flutter/material.dart';
import './home.dart';
import './map.dart';

class Welcome extends StatefulWidget {
  static String id = "welcome";
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var imageURL =
      'https://cdn.discordapp.com/attachments/867295602453905448/868867538363220048/00_loadingPhone_UIUX.png';
  var images = [
    'https://cdn.discordapp.com/attachments/867295602453905448/868867541395730533/01-splashPhone_UIUX.png',
    'https://cdn.discordapp.com/attachments/867295602453905448/868867540129026068/02-splashPhone_UIUX.png',
    'https://cdn.discordapp.com/attachments/867295602453905448/868867541857108008/03-splashPhone_UIUX.png',
    'https://cdn.discordapp.com/attachments/867295602453905448/868867540145807371/04-splashPhone_UIUX.png',
    'https://cdn.discordapp.com/attachments/867295602453905448/868881713919578162/unknown.png',
    'https://cdn.discordapp.com/attachments/867295602453905448/868881801555349584/unknown.png',
  ];
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 5) {
          Navigator.pushNamed(context, Home.id);
        } else {
          index++;
          setState(() {
            imageURL = images[index];
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(imageURL), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
