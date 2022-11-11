import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/lugar_model.dart';

class LugarTuristicoModel extends Equatable{
  LugarModel lugarTuristico;
  File fileImage;

  LugarTuristicoModel({
    required this.lugarTuristico,
    required this.fileImage,
  });

  @override
  List<Object> get props => [
    lugarTuristico,
    fileImage,
  ];

  LugarModel get gLugar => lugarTuristico;
  File get gFile => fileImage;
  String get gLugarNombre => lugarTuristico.nombre;

  set slugarTuristico(LugarModel lugar) => lugarTuristico = lugar;
  set sfileImage(File image) => fileImage = image;
}