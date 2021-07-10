import 'package:dio/dio.dart';
import 'package:pruebaapi/src/models/api_models.dart';

class ApiProvider {
  final _url = 'https://rickandmortyapi.com/api/character';
  final _http = Dio();

//obtener personajes ya contiene los datos de la api para hacer el diseño de la app

  Future<List<ApiModel>> obtenerPersonajes(int pagina) async {
    final response = await _http.get(_url, queryParameters: {'page': pagina});
    List<dynamic> data = response.data['results'];
    return data.map((api) => ApiModel.transInstancia(api)).toList();
  }

  Future<ApiModel> personajePorIdoNombre(String query) async {
    final response = await _http.get('$_url/$query');
    return ApiModel.transInstancia(response.data);
  }
}
