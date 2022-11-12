import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:holotourismfront/models/lugar_model.dart';
import 'package:holotourismfront/models/res_lugar_model.dart';
import 'package:holotourismfront/models/usuario_model.dart';
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


// ResLugarModel test
  group('ResLugarModel model tests', () {
    var lugar = ResLugarModel(id: '', tourname: '', filename: '',
        description: '', latitude: '', longitude: '', fileUrl: '',
        user: '', v: '');
    late Map<String,dynamic> json;

    setUp(() {
      json = {
        'id': '1',
        'tourname': 'tourcito',
        'filename':  'filename',
        'description':  'description',
        'latitude':  'latitude',
        'longitude':  'longitude',
        'fileUrl':  'fileUrl',
        'user':  'user',
        'v':  'v',
      };
    });

    test('lugar debe empezar sin valores', () {
      expect(lugar.id, '');
      expect(lugar.tourname, '');
      expect(lugar.filename, '');
      expect(lugar.description, '');
      expect(lugar.latitude, '');
      expect(lugar.longitude, '');
      expect(lugar.fileUrl, '');
      expect(lugar.user, '');
      expect(lugar.v, '');
    });

    test('Lugar tiene las propiedades correctas', () {
      final lugar2 = ResLugarModel.fromJson(json);
      expect(lugar2.id, '1' );
      expect(lugar2.tourname, 'tourcito' );
      expect(lugar2.filename, 'filename' );
      expect(lugar2.description, 'description' );
      expect(lugar2.latitude, 'latitude' );
      expect(lugar2.longitude, 'longitude' );
      expect(lugar2.fileUrl, 'fileUrl' );
      expect(lugar2.user, 'user' );
      expect(lugar2.v, 'v' );
    });

  });

  //UsuarioModel test
  group('UsuarioModel model tests', () {
    var usuario = UsuarioModel(ok: true, uid: '', nombre: '', token: '');
    late Map<String,dynamic> json;

    setUp(() {
      json = {
        'ok': true,
        'uid': 'uid',
        'nombre':  'nombre',
        'token':  'token',
      };
    });

    test('usuario debe empezar sin valores', () {
      expect(usuario.ok, true);
      expect(usuario.uid, '');
      expect(usuario.nombre, '');
      expect(usuario.token, '');

    });

    test('usuario tiene las propiedades correctas', () {
      final usuario2 = UsuarioModel.fromJson(json);
      expect(usuario2.ok, true );
      expect(usuario2.uid, 'uid' );
      expect(usuario2.nombre, 'nombre' );
      expect(usuario2.token, 'token' );
    });

  });
}
