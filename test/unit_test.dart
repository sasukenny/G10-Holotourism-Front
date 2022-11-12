import 'package:flutter_test/flutter_test.dart';
import 'package:holotourismfront/models/lugar_model.dart';

void main() {
  group('Lugar model tests', () {
    late LugarModel lugar;
    late Map<String,dynamic> json;

    setUp(() {
      json = {
        'ok': true,
        'nombre': 'test',
        'latitud': '0',
        'longitud': '0',
      };
      lugar = LugarModel(ok: true, nombre: 'test', latitud: '0', longitud: '0');
    });

    test('Lugar debe empezar sin descripción', () {
      expect(lugar.descripcion, 'sin descripcion');
    });

    test('Lugar tiene las propiedades correctas', () {
      final lugar2 = LugarModel.fromJson(json);
      expect(lugar2.ok, true);
      expect(lugar2.nombre, 'test');
      expect(lugar2.latitud, '0');
      expect(lugar2.longitud, '0');
    });

  });


}
