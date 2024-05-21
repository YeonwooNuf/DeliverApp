import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:delivery/pages/AddressInfo.dart';

class AddressMapPage extends StatefulWidget {
  @override
  _AddressMapPageState createState() => _AddressMapPageState();
}

class _AddressMapPageState extends State<AddressMapPage> {
  late GoogleMapController mapController;
  LatLng? _center;
  LatLng? _arrowPosition;
  String _location = "주소를 찾는 중...";
  final String gpsApiKey = 'AIzaSyBO79ON_kRsXLe5IesAEBDVOG4YW0Ze4v8';

  @override
  void initState() {
    super.initState();
    _checkPermissionAndGetCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _arrowPosition = position.target;
    });

    _getAddressFromLatLng(position.target);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      String gpsUrl =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$gpsApiKey';
      final responseGps = await http.get(Uri.parse(gpsUrl));
      final json = convert.jsonDecode(responseGps.body);
      if (json['status'] == 'OK') {
        setState(() {
          _location = json['results'][0]['formatted_address'];
        });
      } else {
        setState(() {
          _location = "주소를 찾을 수 없습니다.";
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _location = "주소를 가져오는 중 오류 발생.";
      });
    }
  }

  Future<void> _checkPermissionAndGetCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('위치 서비스가 비활성화되어 있습니다.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('위치 권한이 거부되었습니다.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('위치 권한이 영구적으로 거부되었습니다.');
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
      });

      // 현재 위치를 바탕으로 주소 가져오기
      _getAddressFromLatLng(LatLng(position.latitude, position.longitude));
    } catch (e) {
      print(e);
      _showErrorDialog(e.toString());
    }
  }

  void _goToCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    } catch (e) {
      print(e);
      _showErrorDialog('현재 위치로 이동하는데 실패했습니다: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('오류'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onRegisterButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressInfo(searchedAddress: _location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지도 테스트'),
      ),
      body: _center == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  onCameraMove: _onCameraMove,
                  initialCameraPosition: CameraPosition(
                    target: _center!,
                    zoom: 18.0,
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.location_pin,
                    size: 40.0,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: FloatingActionButton(
                    onPressed: _goToCurrentLocation,
                    tooltip: '현재 위치로 이동',
                    child: Icon(Icons.gps_fixed),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.18, // Set height as a fraction of the screen height
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SingleChildScrollView(
                            child: Text(
                              '$_location',
                              style: TextStyle(fontSize: 20.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: double.infinity, // Set width as per your requirement
                            height: 50.0, // Set height as per your requirement
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: _onRegisterButtonPressed,
                              child: Text(
                                '설정하기',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
