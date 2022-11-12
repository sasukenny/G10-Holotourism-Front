part of 'lugarbloc_bloc.dart';

abstract class LugarblocState extends Equatable {
  const LugarblocState();

  @override
  List<Object> get props => [];
}

class LugarblocInitial extends LugarblocState {
  final List<LugarTuristicoModel> lugarTuristicos;
  final String token;
  const LugarblocInitial({this.lugarTuristicos = const [], this.token = ''});

  @override
  List<Object> get props => [lugarTuristicos, token];

}

class LugarblocStarted extends LugarblocState {
  final List<LugarTuristicoModel> lugarTuristicos;
  final String token;
  const LugarblocStarted({required this.lugarTuristicos, required this.token});

  @override
  List<Object> get props => [lugarTuristicos, token];

}

class LugarblocLoaded extends LugarblocState {
  final List<LugarTuristicoModel> lugarTuristicos;
  final String token;
  const LugarblocLoaded({required this.lugarTuristicos, required this.token});

  @override
  List<Object> get props => [lugarTuristicos, token];

}