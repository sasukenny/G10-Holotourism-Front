// import 'dart:js';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as Path;



import '../../models/lugar_model.dart';
import 'ubicacion.dart';


class Primera extends StatelessWidget {
  File imagen;
  LugarModel title;

  Primera({super.key, required this.imagen, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Color(0xFF00ac83),
      ),
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                blurRadius: 25.0,
                spreadRadius: 5.0,
                offset: Offset(5.0, 5.0))
          ],
          color: Color(0xFFEEEDDE),
        ),

        //margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title.nombre,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Image.file(
                imagen,
                width: 450.0,
              ),
              Text(title.descripcion),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 25.0,
                      spreadRadius: 5.0,
                      offset: Offset(5.0, 5.0))
                ], color: Colors.green, borderRadius: BorderRadius.circular(1)),
                child: Boton(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Boton(context) {
    return TextButton(
        child: Text(
          'Ir a ubicación',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: Color.fromRGBO(15, 242, 187, 1),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 3),
            )),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Location(
                        lugar: title,
                      )));
        });
  }
}
