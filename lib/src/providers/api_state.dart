import 'package:get/get.dart';
import 'package:pruebaapi/src/models/api_models.dart';
import 'package:pruebaapi/src/providers/api_provider.dart';

class PerState extends GetxController {
  List<ApiModel> personajes = [];
  final perState = ApiProvider();
  int _pagina = 1;

  Future<void> obtenerPersonajes() async {
    personajes.addAll(await perState.obtenerPersonajes(_pagina));
    _pagina = _pagina + 1;
    update();
  }
}
