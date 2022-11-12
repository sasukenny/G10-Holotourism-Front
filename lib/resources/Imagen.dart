import 'dart:convert';
import 'dart:typed_data';

import 'package:holotourismfront/models/lugar_model.dart';
import 'package:holotourismfront/models/lugar_turistico_model.dart';
import 'package:holotourismfront/models/res_lugar_model.dart';
import 'package:holotourismfront/models/url_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'dart:io';



class Imagen {
  Future<String> subir(String field, String filePath) async {
    var request = http.MultipartRequest("POST",
        Uri.parse('http://192.168.1.2:8081/api/images/saveimg/'));
    request.fields["file"] = field;
    request.files.add(await http.MultipartFile.fromPath("file", filePath));
    request.headers.addAll({"Content-type": "multipart/form-data"});

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    if (response.statusCode == 200) {
      UrlModel url = UrlModel.fromJson(jsonDecode(respStr));
      return url.url;
    } else {
      throw Exception('Error al subir imagen');
    }
  }

  Future<LugarModel> detectar(String fileName) async {
    var response = await http.post(
      Uri.parse('http://192.168.1.2:8081/api/detector/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fileName': fileName,
      }),
    );
    // String c = await Imagen.getDescriptions(jsonDecode(response.body));
    String c = 'Descripcion de prueba';
    print("Descpcion del sistema" + c);
    if (response.statusCode == 200) {
      LugarModel lugar = LugarModel.fromJson(jsonDecode(response.body));
      lugar.descripcion = c;
      return lugar;
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<LugarTuristicoModel>> mostrarImagen(String xtoken) async {
    var i = 1;
    List<ResLugarModel> resModel;
    List<LugarTuristicoModel> model = <LugarTuristicoModel>[];
    var response = await http.get(
      Uri.parse('http://192.168.1.2:8081/api/images/showimages/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-token': xtoken,
      }
    );
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["images"];
    resModel = List<ResLugarModel>.from(data.map((i) => ResLugarModel.fromJson(i)));

    print(resModel);

    for (var element in resModel) {
      LugarModel lugar = LugarModel(
          ok: true,
          nombre: element.gtourname,
          latitud: element.glatitude,
          longitud: element.glongitude,
      );
      lugar.descripcion = element.description;
      final http.Response responseData = await http.get(Uri.parse(element.fileUrl));
      Uint8List uint8list = responseData.bodyBytes;
      var buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);
      var tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/imgs$i').writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      print(file);
      LugarTuristicoModel turistico = LugarTuristicoModel(lugarTuristico: lugar, fileImage: file);
      model.add(turistico);
      print(model);
      i++;
    }

    if (model.isNotEmpty){
      return model;
    } else {
      return [];
    }
  }

  Future<String> guardarDB(LugarModel lugar, String xtoken, String nombre) async {
    var response = await http.post(
      Uri.parse('http://192.168.1.2:8081/api/images/savedbimg/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-token': xtoken,
      },
      body: jsonEncode(<String, String>{
        'tourname': lugar.nombre,
        'filename': nombre,
        'description': lugar.descripcion,
        'latitude': lugar.latitud,
        'longitude': lugar.longitud,
        'fileUrl': lugar.url,
      }),
    );
    if (response.statusCode == 201) {
      return 'funciono';
    } else {
      throw Exception(response.body);
    }
  }

  static Future<String> getDescriptions(Map<String, dynamic> json) async {
    String nombre = json['nombre'].toString();
    var url = Uri.parse(
        'http://192.168.1.2:8081/api/description/${nombre}');
    var response = await http.get(url);
    //print(json['nombre'].toString() + " nombre");
    //print('status: ${response.statusCode}');
    //print('body: ${response.body}');
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['desc'].length <= 0) {
      //print("no hay descripcion disponible");
      return "no hay descripcion disponible";
    } else {
      //print(" desc: " + res['desc'].toString());
      return res['desc'].toString();
    }
  }
}
