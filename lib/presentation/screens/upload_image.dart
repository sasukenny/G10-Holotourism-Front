import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/lugarbloc/lugarbloc_bloc.dart';

const topColor = Color(0xFF00ac83);

class UploadImage extends StatefulWidget {

  UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage>{
  int _counter = 0;
  final imagePicker = ImagePicker();
  late final List<bool> _selections;

  @override
  void initState() {
    _selections = [false, true];
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LugarblocBloc, LugarblocState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/logohastalqso.png',fit: BoxFit.cover, height: 60,width: 70),
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
          body: Padding(
            padding: EdgeInsets.all(40.0),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      context.read<LugarblocBloc>().add(AddLugarTuristico(fileImage: await _openCamera()));
                    },
                    child: const Text('Cámara'),
                    style: ElevatedButton.styleFrom(
                      primary: topColor
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<LugarblocBloc>().add(AddLugarTuristico(fileImage: await _openGallery()));
                    },
                    child: const Text('Galería'),
                    style: ElevatedButton.styleFrom(
                        primary: topColor
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
}

