import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/lugarbloc/lugarbloc_bloc.dart';
import '../../models/lugar_model.dart';


class HomeScreenDialogs extends StatefulWidget {
  late LugarModel futureLugar;
  final imagePicker = ImagePicker();
  String fileName = '';
  String fileDescription = '';

  HomeScreenDialogs({Key? key}) : super(key: key);

  Future build(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<LugarblocBloc, LugarblocState>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text('Subir imagen'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          // await _openCamera();
                          // callbackFunction(images2, fileName);
                          context.read<LugarblocBloc>().add(AddLugarTuristico(fileImage: await _openCamera()));
                        },
                        child: const Text('Cámara'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // await _openGallery();
                          // callbackFunction(images2, fileName);
                          context.read<LugarblocBloc>().add(AddLugarTuristico(fileImage: await _openGallery()));
                        },
                        child: const Text('Galería'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
      });
  }
  Future<File> _openCamera() async {
    XFile picture = (await imagePicker.pickImage(
      source: ImageSource.camera,
    )) as XFile;

    File images2 = File(picture.path);
    return images2;
  }
  Future<File> _openGallery() async {
    XFile picture = (await imagePicker.pickImage(
      source: ImageSource.gallery,
    )) as XFile;
    File images2 = File(picture.path);
    return images2;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
