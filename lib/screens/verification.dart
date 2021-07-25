import 'package:flutter/material.dart';
import './home.dart';
import './map.dart';

class Verification extends StatefulWidget {
  static String id = "verification";
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  var imageURL =
      'https://cdn.discordapp.com/attachments/746672699144798310/868906786256748564/unknown.png';
  var images = [
    'https://cdn.discordapp.com/attachments/746672699144798310/868906914644381736/unknown.png',
    'https://cdn.discordapp.com/attachments/746672699144798310/868907072115331122/unknown.png',
    'https://cdn.discordapp.com/attachments/746672699144798310/868907111508238366/unknown.png'
  ];
  var index = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(70.0), // here the desired height
            child: AppBar(
              automaticallyImplyLeading:
                  false, // you can put Icon as well, it accepts any widget.
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
              backgroundColor: Colors.white,
              centerTitle: true,
            )),
        body: GestureDetector(
          onTap: () {
            if (index == 2) {
              Navigator.pushNamed(context, Map.id);
            } else {
              index++;
              setState(() {
                imageURL = images[index];
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageURL), fit: BoxFit.cover),
            ),
          ),
        ));
  }
}
