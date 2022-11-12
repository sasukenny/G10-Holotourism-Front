import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class UsuarioModel extends Equatable{
  final bool ok;
  final String uid;
  final String nombre;
  final String token;

  const UsuarioModel({
    required this.ok,
    required this.uid,
    required this.nombre,
    required this.token,
  });

  @override
  List<Object> get props => [
    ok,
    uid,
    nombre,
    token,
  ];

  String get gUid => uid;
  String get gNombre => nombre;
  String get gToken => token;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      ok: json['ok'],
      nombre: json['name'],
      uid: json['uid'],
      token: json['token'],
    );
  }
}