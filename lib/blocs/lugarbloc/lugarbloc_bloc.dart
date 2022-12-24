import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holotourismfront/models/lugar_model.dart';
import 'package:holotourismfront/models/lugar_turistico_model.dart';
import 'dart:io';

import '../../resources/Imagen.dart';

part 'lugarbloc_event.dart';
part 'lugarbloc_state.dart';

class LugarblocBloc extends Bloc<LugarblocEvent, LugarblocState> {
  
  LugarblocBloc() : super(LugarblocInitial()) {
    on<LoadLugarTuristicos>(_onLoadLugarTuristicos);
    on<AddLugarTuristico>(_onAddLugarTuristico);
  }

  Future<void> _onLoadLugarTuristicos(LoadLugarTuristicos event, Emitter<LugarblocState> emit) async {
    final imagen = Imagen();
    List<LugarTuristicoModel> lugar = await imagen.mostrarImagen(event.token);
    print('despues de cargar');
    print(lugar);
    if (lugar.isEmpty){
      emit(
        LugarblocStarted(lugarTuristicos: const [], token: event.token),
      );
    }
    else {
      emit(
        LugarblocLoaded(lugarTuristicos: lugar, token: event.token),
      );
    }
  }

  Future<void> _onAddLugarTuristico(AddLugarTuristico event, Emitter<LugarblocState> emit) async {
/*    debugPrint('evento Dummy');
    final state = this.state;
    LugarModel lugar = LugarModel (
      ok: true,
      nombre: 'aea',
      latitud: 'gaeea',
      longitud: 'mongol',
    );
    var picture = event.fileImage;
    print(state);
    LugarTuristicoModel lugarTuristico = LugarTuristicoModel(lugarTuristico: lugar, fileImage: picture);

    if(state is LugarblocLoaded){
      debugPrint('evento Lanzado');
      print(lugarTuristico);
      emit(
        LugarblocLoaded(lugarTuristicos: List.from(state.lugarTuristicos)..add(lugarTuristico), token: state.token),
      );
    }
    if(state is LugarblocInitial){
      debugPrint('evento Lanzado');
      print(lugarTuristico);
      emit(
        LugarblocLoaded(lugarTuristicos: List.from(state.lugarTuristicos)..add(lugarTuristico), token: state.token),
      );
    }*/

    final imagen = Imagen();
    late LugarModel futureLugar;
    var picture = event.fileImage;
    final state = this.state;
    debugPrint("picture.path.split().last,: " + picture.path.split("/").last,);
    final url = await imagen.subir(picture.path.split("/").last, picture.path);
    debugPrint("url: " + url);
    if(url != ''){
      futureLugar = await imagen.detectar(picture.path.split("/").last);
      futureLugar.url = url;
      debugPrint('funciono mi king');
      debugPrint(state.toString());
      if(state is LugarblocLoaded){
        debugPrint('Emitiendo evento con array cargado');
        print(state.token);
        print(await imagen.guardarDB(futureLugar, state.token, picture.path.split("/").last));
        LugarTuristicoModel lugarTuristico = LugarTuristicoModel(lugarTuristico: futureLugar, fileImage: picture);
        emit(
          LugarblocLoaded(lugarTuristicos: List.from(state.lugarTuristicos)..add(lugarTuristico), token: state.token),
        );
      }
      if(state is LugarblocStarted){
        debugPrint('Emitiendo evento con array nuevo');
        print(state.token);
        print(await imagen.guardarDB(futureLugar, state.token, picture.path.split("/").last));
        LugarTuristicoModel lugarTuristico = LugarTuristicoModel(lugarTuristico: futureLugar, fileImage: picture);
        emit(
          LugarblocLoaded(lugarTuristicos: List.from(state.lugarTuristicos)..add(lugarTuristico), token: state.token),
        );
      }
    } else {
      debugPrint('No funciono mi king');
    }
  }
}
