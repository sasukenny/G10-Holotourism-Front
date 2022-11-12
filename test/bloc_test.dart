import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:holotourismfront/blocs/lugarbloc/lugarbloc_bloc.dart';

void main() {
  group('Lugar bloc test', () {
    late LugarblocBloc lugarBloc;
    
    setUp(() {
      lugarBloc = LugarblocBloc();
    });
    
    test('Bloc inicial', () {
      expect(lugarBloc.state, const LugarblocInitial());
    });

    // blocTest<LugarblocBloc, LugarblocState>(
    //   'Agregar lugar turistico',
    //   build: () => lugarBloc,
    //   act: (bloc) => bloc.add(AddLugarTuristico(fileImage: ''))
    //
    // );
    //
    // blocTest<LugarblocBloc, LugarblocState>(
    //   'Load lugar turistico',
    //   build: () => lugarBloc,
    //   act: (bloc) => bloc.add(LoadLugarTuristicos(token: ''))
    // );

  });


}