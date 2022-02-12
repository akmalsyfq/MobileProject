import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'delivery.dart';
import 'mappage.dart';
import 'package:ndialog/ndialog.dart';

class AddAddressPage extends StatefulWidget {
  final email;
  const AddAddressPage({Key? key, this.email}) : super(key: key);
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  String address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        title: Text('Address',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            )),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      Text(
                        "Add New Address",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      buildTextField("Name", "Name", "name"),
                      buildTextField("Contact", "Contact Number", "contact"),
                      TextField(
                        enabled: true,
                        controller: _addressController,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          labelText: "Address",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                          hintText: 'Search address',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 4,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pinkAccent,
                              ),
                              onPressed: () async {
                                Delivery _del =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MapPage(),
                                  ),
                                );
                                setState(() {
                                  _del == null
                                      ? _addressController.text =
                                          "No location selected."
                                      : _addressController.text = _del.address;
                                });
                              },
                              child: Text("Map"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () {
                          _updateaddress();
                        },
                        color: Colors.pinkAccent,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, String textField) {
    if (textField == "contact") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                //color: Colors.black,
              )),
          controller: _contactController,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),
          controller: _nameController,
        ),
      );
    }
  }

  _updateaddress() {
    FocusScope.of(context).unfocus();
    String _name = _nameController.text.toString();
    String _contact = _contactController.text.toString();
    String _address = _addressController.text.toString();

    if (_name.isEmpty || _contact.isEmpty || _address.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please do not leave any text fields blank.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }
    if (_name.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>~]'))) {
      Fluttertoast.showToast(
        msg: "Full name should not contain special character",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_name.contains(RegExp(r'[0-9]'))) {
      Fluttertoast.showToast(
        msg: "Full name should not contain number",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if ((_contact.length < 10 || _contact.length > 13) &&
        _contact != "") {
      Fluttertoast.showToast(
        msg: "Invalid phone length",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else {
      http.post(Uri.parse(MyConfig.server + "/bellacosa/php/add_address.php"),
          body: {
            "email": widget.email,
            "name": _name.toUpperCase(),
            "address": _address.toUpperCase(),
            "phone": _contact,
          }).then((response) {
        if (response.body == "Success") {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Success.", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
          setState(() {});
          return;
        } else if (response.body == "Already Exist") {
          Fluttertoast.showToast(
              msg: "Already Exist.",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 16.0);
          setState(() {});
        } else {
          Fluttertoast.showToast(
              msg: "Please Try Again.",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 16.0);
          setState(() {});
        }
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _getPlace(Position pos) async {
    MarkerId markerId1 = MarkerId("12");
    List<Placemark> newPlace =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Set<Marker> markers = Set();
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    address = name +
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

    String _address = "No location selected";
    markers.clear();
    markers.add(Marker(
      markerId: markerId1,
      position: LatLng(pos.latitude, pos.longitude),
      infoWindow: InfoWindow(
        title: 'Address',
        snippet: _address,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
  }
}
