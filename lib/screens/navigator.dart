import 'package:flutter/material.dart';
import './welcome.dart';
import './map.dart';
import './home.dart';

class Navigation extends StatefulWidget {
  static String id = "navigation";

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int pageIndex = 0;
  int firstIconColorInt = 1;
  int secondIconColorInt = 0;
  int thirdIconColorInt = 0;
  int fourthIconColorInt = 0;
  List _currentPage = [Home(), Map(), Home(), Home()];
  List _iconColors = [Colors.white54, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          child: _currentPage[pageIndex],
        ),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 120,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: _iconColors[firstIconColorInt],
                    ),
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                        firstIconColorInt = 1;
                        secondIconColorInt = 0;
                        thirdIconColorInt = 0;
                        fourthIconColorInt = 0;
                      });
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.qr_code,
                          color: _iconColors[secondIconColorInt]),
                      onPressed: () {
                        setState(() {
                          pageIndex = 1;
                          firstIconColorInt = 0;
                          secondIconColorInt = 1;
                          thirdIconColorInt = 0;
                          fourthIconColorInt = 0;
                        });
                      },
                      padding: EdgeInsets.only(right: 120)),
                  IconButton(
                      icon: Icon(Icons.menu,
                          color: _iconColors[thirdIconColorInt]),
                      onPressed: () {
                        setState(() {
                          pageIndex = 3;
                          firstIconColorInt = 0;
                          secondIconColorInt = 0;
                          thirdIconColorInt = 1;
                          fourthIconColorInt = 0;
                        });
                      },
                      padding: EdgeInsets.only(left: 120)),
                  IconButton(
                    icon: Icon(Icons.info_rounded,
                        color: _iconColors[fourthIconColorInt]),
                    onPressed: () {
                      setState(() {
                        pageIndex = 4;
                        firstIconColorInt = 0;
                        secondIconColorInt = 0;
                        thirdIconColorInt = 0;
                        fourthIconColorInt = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            color: Colors.blueAccent,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              pageIndex = 2;
              firstIconColorInt = 0;
              secondIconColorInt = 0;
              thirdIconColorInt = 0;
              fourthIconColorInt = 0;
            });
          },
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ));
  }
}
