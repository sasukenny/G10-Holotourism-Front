part of 'lugarbloc_bloc.dart';

abstract class LugarblocEvent extends Equatable {
  const LugarblocEvent();

  @override
  List<Object> get props => [];
}
class LoadLugarTuristicos extends LugarblocEvent {
  final List<LugarTuristicoModel> lugarTuristicos;
  final String token;
  const LoadLugarTuristicos({
    this.lugarTuristicos = const<LugarTuristicoModel>[],
    required this.token
  });

  @override
  List<Object> get props => [lugarTuristicos];

}

class AddLugarTuristico extends LugarblocEvent {
  final File fileImage;

  const AddLugarTuristico({required this.fileImage});

  @override
  List<Object> get props => [fileImage];
}

