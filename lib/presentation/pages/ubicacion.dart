import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/lugar_model.dart';


const topColor = Color(0xFF00ac83);

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

class Location extends StatefulWidget {
  final LugarModel lugar;
  Location({Key? key, required this.lugar}) : super(key: key);
  @override
  _LocationState createState() => _LocationState(lugar: lugar);
}

class _LocationState extends State<Location> {
  LugarModel lugar;
  _LocationState({required this.lugar});
  int _counter = 0;

  late final List<bool> _selections;
  final Set<Marker> _marker = Set();
  @override
  late GoogleMapController _mapController;
  List<LatLng> polyneCoordinates = [];
  Set<Polyline> _route = Set();

  void initState() {
    _selections = [false, true];
    super.initState();
  }

  //final GoogleMapController _mapController;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void actualizaRuta(Position position) {
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId(_counter.toString()),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: "Estas aqui",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
      ));
    });
    _centerView();
  }

  //GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    print(lugar.nombre);
    debugPrint(lugar.toString());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 237, 222, 1),
      appBar: AppBar(
        title: Image.asset('assets/logohastalqso.png',
            fit: BoxFit.cover, height: 60, width: 70),
        actions: <Widget>[
          ToggleButtons(
            isSelected: _selections,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _selections.length; i++) {
                  _selections[i] = i == index;
                  debugPrint('movieTitle: $_selections');
                }
              });
            },
            fillColor: const Color(0xFF0FF2BC),
            splashColor: const Color(0xFF0FF2BC),
            children: const [
              Icon(Icons.format_list_bulleted),
              Icon(Icons.grid_view_sharp)
            ],
          )
        ],
        backgroundColor: topColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(lugar.nombre,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: _mapa()),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                decoration: BoxDecoration(
                  boxShadow: [shadowButton()],
                ),
                child: ElevatedButton(
                  child: Text(
                    'Trazar ruta desde mi ubicación',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    //print(_determinePosition());
                    _determinePosition().then((position) {
                      actualizaRuta(position);
                      getPolyPoints(position);
                    });
                    _centerView();
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _mapa() {
    markers();
    //_obtenerUbicacion();

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target:
            LatLng(double.parse(lugar.latitud), double.parse(lugar.longitud)),
        zoom: 10,
      ),
      mapType: MapType.hybrid,
      markers: _marker,
      onMapCreated: _onMapCreated,
      polylines: _route,
    );
  }

  void markers() {
    _marker.add(
      Marker(
        markerId: MarkerId('1'),
        position:
            LatLng(double.parse(lugar.latitud), double.parse(lugar.longitud)),
        infoWindow: InfoWindow(
          title: lugar.nombre,
          snippet: lugar.descripcion,
        ),
      ),
    );
  }

  //función para agregar un marcador en el mapa
  void _centerView() async {
    setPolyline();

    Position position = await _determinePosition();
    await _mapController.getVisibleRegion();
    var left = min(position.latitude, double.parse(lugar.latitud));
    var right = max(position.latitude, double.parse(lugar.latitud));
    var top = max(position.longitude, double.parse(lugar.longitud));
    var bottom = min(position.longitude, double.parse(lugar.longitud));
    var bounds = LatLngBounds(
        southwest: LatLng(left, bottom), northeast: LatLng(right, top));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    //_centerView();
  }

  void setPolyline() {
    _route.add(Polyline(
        polylineId: PolylineId("route"),
        points: polyneCoordinates,
        color: Colors.blue,
        width: 5));
  }

  void getPolyPoints(Position position) {
    setState(() {
      polyneCoordinates.add(LatLng(position.latitude, position.longitude));
      polyneCoordinates.add(
          LatLng(double.parse(lugar.latitud), double.parse(lugar.longitud)));
    });
  }

  void getPolyPoints2() async {
    Position position = await _determinePosition();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCBSTZCQrT_9s4-vTpWlzR29J-buEj0o18",
        PointLatLng(position.latitude, position.longitude),
        //PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(double.parse(lugar.latitud), double.parse(lugar.longitud)));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyneCoordinates.add(LatLng(point.latitude, point.longitude)));

      setState(() {});
    }
  }
}

BoxShadow shadowButton() {
  return const BoxShadow(
    color: Colors.black,
    spreadRadius: 1,
    blurRadius: 1,
    offset: Offset(2, 2),
    // changes position of shadow
  );
}
