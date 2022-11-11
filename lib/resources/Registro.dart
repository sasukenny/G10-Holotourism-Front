import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/usuario_model.dart';



/*
*
* CLASE PARA REGISTRO Y LOGIN CON EL BACK-END
*
* */

class Registro {

  Future<String> registrar(String nombres, String apellidos, String numero_celular, String correo, String password) async {
    var response = await http.post(
      Uri.parse('https://holotourism.herokuapp.com/api/auth/new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombres,
        'apellido': apellidos,
        'email': correo,
        'movil': numero_celular,
        'password': password
      }),
    );
    if (response.statusCode == 201){
      return 'ok';
    } else {
      return 'a';
    }
  }

}



