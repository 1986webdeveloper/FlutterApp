import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:picture_on_map/Menu/MenuScreen.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:picture_on_map/Model/PictureModel.dart';
import 'package:picture_on_map/NetworkUtil.dart';
import 'package:picture_on_map/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeSceenState();
  }
}

class _HomeSceenState extends State<HomeScreen> {
  GoogleMapController _mapController;

  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  bool _permission = false;
  String error;
  List<PicutreModelData> _loginData;

  Future<PicutreModelData> getPicturedata() async {
    var urlString = '$baseUrl/picture_map';
    var userId = App.localStorage.getInt(kUserId);
    print(urlString);
    print(userId.toString());
    return NetworkUtil.internal().post(urlString, body: {
      'user_id': userId.toString(),
      'distance': '50',
      'lat': _currentLocation['latitude'].toString(),
      'long': _currentLocation['longitude'].toString()
    }).then((dynamic res) {
      var meta = PictureModel.map(res);

      if (meta.status == true) {
        _loginData = meta.data;
        dispalyMessage(meta.message);
        for (int i = 0; i < _loginData.length; i++) {
          var item = _loginData[i];
          _mapController.addMarker(
            MarkerOptions(
              position: LatLng(
                  double.parse(item.latitude), double.parse(item.longitude)),
            ),
          
          );
        }
      }
      return null;
    });
  }

  void dispalyMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }

  @override
  void initState() {
    super.initState();

    initPlatformState();
    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(
            _currentLocation["latitude"],
            _currentLocation["longitude"],
          ),
          17.0));
      _currentLocation = result;
      getPicturedata();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }
    _currentLocation = location;
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    _mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(
          _currentLocation["latitude"],
          _currentLocation["longitude"],
        ),
        17.0));

    getPicturedata();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    if (_currentMapType == MapType.normal) {
      setState(() {
        _mapController.updateMapOptions(
          GoogleMapOptions(mapType: MapType.satellite),
        );
        _currentMapType = MapType.satellite;
      });
    } else {
      setState(() {
        _mapController.updateMapOptions(
          GoogleMapOptions(mapType: MapType.normal),
        );
        _currentMapType = MapType.normal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuScreen(),
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(fontFamily: "Raleway", fontSize: 20.0),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              options: GoogleMapOptions(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  cameraPosition: _currentLocation == null
                      ? CameraPosition(target: LatLng(0.0, 0.0))
                      : CameraPosition(
                          target: LatLng(_currentLocation["latitude"],
                              _currentLocation["longitude"]),
                          zoom: 17.0,
                        )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () {
                    _onMapTypeButtonPressed();
                  },
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 36.0),
                ),
              ),
            ),
          ],
        ));
  }
}
