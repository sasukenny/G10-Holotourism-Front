import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:holotourismfront/models/lugar_model.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('Lugar model tests', () {
    var lugar = LugarModel(ok: true, nombre: 'test', latitud: '0', longitud: '0');
    late Map<String,dynamic> json;

    setUp(() {
      json = {
        'ok': true,
        'nombre': 'test',
        'latitud': '0',
        'longitud': '0',
      };
    });

    test('Lugar debe empezar sin descripción', () {
      expect(lugar.descripcion, 'sin descripcion');
    });

    test('Lugar tiene las propiedades correctas', () {
      final lugar2 = LugarModel.fromJson(json);
      expect(lugar2.ok, true);
      expect(lugar2.nombre, 'test');
      expect(lugar2.latitud, '0');
      expect(lugar2.longitud, '0');
    });

    test('Lugar debe de retornar ok',(){
      expect(lugar.ok, true);
    });

    test('Lugar debe de retornar nombre',(){
      expect(lugar.nombre, 'test');
    });

    test('Lugar debe de retornar latitud',(){
      expect(lugar.latitud, '0');
    });

    test('Lugar debe de retornar longitud',(){
      expect(lugar.longitud, '0');
    });

    test('Descripcion debe de poderse setear',(){
      lugar.descripcion = '1';
      expect(lugar.descripcion, '1');
    });

    test('url debe de poderse setear',(){
      lugar.url = '1';
      expect(lugar.url, '1');
    });
  });


}
