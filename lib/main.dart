import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Anshul Demo Home Page'),
    );
  }
}

Future<String> getMapData() async {
  String lat = '28.389345833667484';
  String lon = '77.05563957581718';
  final mapEndpoint =
      Uri.parse('https://vixit.herokuapp.com/mapdata?lat=$lat&lon=$lon');
  print(mapEndpoint);
  final mapResponse = await http.get(mapEndpoint);

  if (mapResponse.statusCode == 200) {
    return mapResponse.body;
  }

  return 'Error';
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller = Completer();

  static const _initialCameraPosition = CameraPosition(
      target: LatLng(28.389345833667484, 77.05563957581718), zoom: 8.5);

  late String _darkMapStyle;
  bool showDiv = false;
  String city = '';
  var vacc1 = '7.5';
  var vacc2 = '30.05';
  var vacc3 = '69.5';
  var vacc1Pop = "557055";
  var vacc2Pop = "200699";
  var vacc3Pop = "200699";
  var markersToInflate = [];

  final Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _loadMapStyles();
    setCustomMarker();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;
    controller.setMapStyle(_darkMapStyle);
  }

  Future _setCameraPosition(lat, lon) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat - 0.1, lon), zoom: 11)));
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/cmarker.png');
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMapData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data.toString();
            var d = json.decode(data);
            final markersToInflateParam = d;

            return Scaffold(
                appBar: PreferredSize(
                    preferredSize:
                        const Size.fromHeight(70.0), // here the desired height
                    child: AppBar(
                      // here the image
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 30, bottom: 0),
                              child: Center(
                                child: Text("Vixit",
                                    style: TextStyle(
                                        fontFamily: 'Antipasto', fontSize: 30)),
                              ))
                        ],
                      ),
                      backgroundColor: const Color(0xff212135),
                      centerTitle: true,
                    )),
                body: SafeArea(
                    child: Stack(children: [
                  GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _initialCameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        print(markersToInflateParam);
                        markersToInflateParam.forEach((element) {
                          var id = element['id'];
                          List<String>? latlong = element['coords']?.split(',');
                          double latitude = double.parse(latlong![0]);
                          double longitude = double.parse(latlong![1]);
                          var title = element['title'];
                          _markers.add(Marker(
                              markerId: MarkerId(id.toString()),
                              position: LatLng(latitude, longitude),
                              onTap: () {
                                setState(() {
                                  city = title!.toString();
                                  vacc1 = element['vacc1'].toString();
                                  vacc2 = element['vacc2'].toString();
                                  vacc3 = element['vacc3'].toString();
                                  vacc1Pop = element['total']['vaccinated2']
                                      .toString();
                                  vacc2Pop = element['total']['vaccinated1']
                                      .toString();
                                  vacc3Pop = (element['meta']['population'] -
                                          element['total']['vaccinated1'])
                                      .toString();
                                  showDiv = true;
                                  _setCameraPosition(latitude, longitude);
                                });
                              },
                              icon: mapMarker));
                        });
                      });
                      _controller.complete(controller);
                      _setMapStyle();
                    },
                    markers: _markers,
                  ),
                  showDiv
                      ? DraggableScrollableSheet(
                          initialChildSize: 0.50,
                          maxChildSize: 0.50,
                          minChildSize: 0.50,
                          expand: true,
                          builder: (context, controler) {
                            return Container(
                              color: Colors.white,
                              child: ListView(
                                controller: controler,
                                children: [
                                  const Divider(
                                    height: 15,
                                    thickness: 4,
                                    color: Color(0xff212135),
                                    indent: 165,
                                    endIndent: 165,
                                  ),
                                  Container(
                                    height: 50,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Text(city + ', Haryana',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        IconButton(
                                            alignment: Alignment.centerRight,
                                            onPressed: () {
                                              setState(() {
                                                showDiv = false;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.cancel_outlined,
                                                size: 25))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 250,
                                      alignment: Alignment.bottomLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: ListView(
                                        children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Text(
                                                  "Vaccinated population",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ))),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 0),
                                              child: Row(children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 0),
                                                  child:
                                                      CircularPercentIndicator(
                                                    radius: 100.0,
                                                    lineWidth: 7.0,
                                                    animation: true,
                                                    percent:
                                                        double.parse(vacc1) /
                                                            100,
                                                    center: Text(
                                                      vacc1 + '%',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20.0),
                                                    ),
                                                    footer: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 0,
                                                                bottom: 10),
                                                        child:
                                                            Column(children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 30,
                                                                    bottom: 0),
                                                            child: Row(
                                                              children: [
                                                                IconButton(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            0),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    onPressed:
                                                                        () {},
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .person,
                                                                        size:
                                                                            20)),
                                                                Text(
                                                                  vacc1Pop
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Poppins'),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          const Text(
                                                            "Fully \nvaccinated",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 15.0),
                                                          )
                                                        ])),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        const Color(0xff8DCA77),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: 100.0,
                                                      lineWidth: 7.0,
                                                      animation: true,
                                                      percent:
                                                          double.parse(vacc2) /
                                                              100,
                                                      center: Text(
                                                        vacc2 + '%',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 20.0),
                                                      ),
                                                      footer: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 0,
                                                                  bottom: 10),
                                                          child: Column(
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 10,
                                                                      bottom:
                                                                          0),
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                          padding: const EdgeInsets.only(
                                                                              right:
                                                                                  0),
                                                                          alignment: Alignment
                                                                              .centerRight,
                                                                          onPressed:
                                                                              () {},
                                                                          icon: const Icon(
                                                                              Icons.person,
                                                                              size: 20)),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            left:
                                                                                0),
                                                                        child:
                                                                            Text(
                                                                          vacc2Pop
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(fontFamily: 'Poppins'),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Text(
                                                                  "Vaccinated \none dose",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          15.0),
                                                                )
                                                              ])),
                                                      circularStrokeCap:
                                                          CircularStrokeCap
                                                              .round,
                                                      progressColor:
                                                          const Color(
                                                              0xffFFC672),
                                                    )),
                                                CircularPercentIndicator(
                                                  radius: 100.0,
                                                  lineWidth: 7.0,
                                                  animation: true,
                                                  percent:
                                                      double.parse(vacc3) / 100,
                                                  center: Text(
                                                    vacc3 + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 20.0),
                                                  ),
                                                  footer: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0,
                                                              bottom: 10),
                                                      child: Column(children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 25,
                                                                  bottom: 0),
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  onPressed:
                                                                      () {},
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .person,
                                                                      size:
                                                                          20)),
                                                              Text(
                                                                vacc3Pop
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Poppins'),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const Text(
                                                          "Not \nvaccined",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 15.0),
                                                        )
                                                      ])),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor:
                                                      const Color(0xffF0535B),
                                                ),
                                              ]))
                                        ],
                                      ))
                                ],
                              ),
                            );
                          })
                      : const SizedBox(width: 0.0)
                ])));
          }
          return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()));
        });
  }
}
