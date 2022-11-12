import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/lugar_turistico_model.dart';
import '../pages/resultado.dart';

class CustomList extends StatelessWidget {

  const CustomList({Key? key, required this.selections, required this.touristicPlaces}) : super(key: key);

  final List<bool> selections;
  final List<LugarTuristicoModel> touristicPlaces;

  @override
  Widget build(BuildContext context) {
    return selections[1] ?
    Padding(
      padding: const EdgeInsets.all(25.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20
          ),
          itemCount: touristicPlaces.length,
          itemBuilder: (context, index) {
            final item = touristicPlaces[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        Primera(imagen: item.gFile, title: item.gLugar))
                );
              },
              child: GridTile(
                  footer: Container(
                    alignment: Alignment.center,
                    color: const Color(0xFFEEEDDE),
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(item.gLugarNombre),
                  ),
                  child: Image.file(item.gFile, fit: BoxFit.cover)
              ),
            );
          }
      ),
    ) : Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView.builder(
          itemCount: touristicPlaces.length,
          itemBuilder: (context, index) {
            final item = touristicPlaces[index];
            return Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  border: Border.all(
                      color: const Color(0xFF000000)
                  )
              ),
              child: ListTile(
                leading: Image.file(
                  item.gFile,
                  height: 50,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          Primera(imagen: item.gFile, title: item.gLugar)
                  ));
                },
                title: Text(item.gLugarNombre),
              ),
            );
          }
      ),
    );
    }
  }
