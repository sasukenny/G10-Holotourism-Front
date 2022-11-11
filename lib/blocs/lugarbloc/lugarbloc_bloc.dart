import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import '../../models/lugar_model.dart';
import '../../models/lugar_turistico_model.dart';

// import '../../resources/Imagen.dart';

part 'lugarbloc_event.dart';
part 'lugarbloc_state.dart';

class LugarblocBloc extends Bloc<LugarblocEvent, LugarblocState> {

  LugarblocBloc() : super(LugarblocInitial()) {
    on<LoadLugarTuristicos>(_onLoadLugarTuristicos);
    on<AddLugarTuristico>(_onAddLugarTuristico);
  }

  Future<void> _onLoadLugarTuristicos(LoadLugarTuristicos event, Emitter<LugarblocState> emit) async {

  }

  Future<void> _onAddLugarTuristico(AddLugarTuristico event, Emitter<LugarblocState> emit) async {

  }
}
