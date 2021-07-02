import 'package:dio/dio.dart';
import 'package:pruebaapi/src/models/api_models.dart';

class ApiProvider {
  final _url = 'https://rickandmortyapi.com/api/character';
  final _http = Dio();

//obtener personajes ya contiene los datos de la api para hacer el diseño de la app

  Future<List<ApiModel>> obtenerPersonajes() async {
    final response = await _http.get(_url);
    List<dynamic> data = response.data;
    return data.map((api) => ApiModel.transInstancia(api)).toList();
  }
}
