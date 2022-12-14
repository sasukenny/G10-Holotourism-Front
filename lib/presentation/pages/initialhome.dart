import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_list.dart';
import 'home.dart';

const topColor = Color(0xFF00ac83);

class InitialHomePage extends StatefulWidget {
  String token;
  InitialHomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<InitialHomePage> createState() => _InitialHomePage();
}

class _InitialHomePage extends State<InitialHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Image.asset("assets/logohastalqso.png", fit: BoxFit.cover, height: 60, width: 70),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            }),
        backgroundColor: topColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              key: const Key('Destinos'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF26A69A),
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                minimumSize: Size(400, 100),
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              icon: Icon(
                Icons.location_city,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {},
              label: Text('Destinos'),
            ),
            Padding(padding: EdgeInsets.all(25.0)),
            ElevatedButton.icon(
              key: Key('misRutas'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF00897B),
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                minimumSize: Size(400, 100),
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              icon: Icon(
                Icons.location_on,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {},
              label: Text('Mis rutas'),
            ),
            Padding(padding: EdgeInsets.all(25.0)),
            ElevatedButton.icon(
              key: Key('Galer??a'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF26A69A),
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                minimumSize: Size(400, 100),
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(token: widget.token))
                );
              },
              label: Text('Galer??a'),
            ),
            Padding(padding: EdgeInsets.all(25.0)),
          ],
        )
      )
    );
  }
  }