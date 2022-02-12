import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'delivery.dart';
import 'package:ndialog/ndialog.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late double screenHeight, screenWidth;
  double dis = 0;
  Set<Marker> markers = Set();
  String _address = "No location selected.";
  late Delivery _delivery;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _shopPosition = const CameraPosition(
    target: LatLng(3.1466, 101.6958),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: Text('Select Location',
            style: TextStyle(
              fontSize: 25,
            )),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                  flex: 7,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _shopPosition,
                    markers: markers.toSet(),
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    onTap: (newLatLng) {
                      _loadAdd(newLatLng);
                    },
                  )),
              Divider(
                height: 5,
              ),
              Flexible(
                  flex: 3,
                  child: Container(
                      width: screenWidth,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text("Please select your delivery address from map",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Container(
                              width: screenWidth / 1.2,
                              child: Divider(),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: screenWidth,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            height: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(_address),
                                            )),
                                        SizedBox(height: 10),
                                        Container(
                                            child: ElevatedButton(
                                                style:
                                                    ElevatedButton.styleFrom(),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, _delivery);
                                                },
                                                child: Text("Save",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ))))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  void _loadAdd(LatLng newLatLng) async {
    MarkerId markerId1 = MarkerId("12");
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Searching address"), title: Text("Locating..."));
    progressDialog.show();
    List<Placemark> newPlace =
        await placemarkFromCoordinates(newLatLng.latitude, newLatLng.longitude);

    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    _address = name +
        ", " +
        subLocality +
        ", " +
        locality +
        ", " +
        postalCode +
        ", " +
        administrativeArea +
        ", " +
        country;
    markers.clear();
    markers.add(Marker(
      markerId: markerId1,
      position: LatLng(newLatLng.latitude, newLatLng.longitude),
      infoWindow: InfoWindow(
        title: 'Address',
        snippet: _address,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
    _delivery = Delivery(_address, newLatLng);
    setState(() {});
    progressDialog.dismiss();
  }
}
