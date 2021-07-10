import 'package:flutter/material.dart';
import 'package:pruebaapi/src/models/api_models.dart';
import 'package:pruebaapi/src/providers/api_provider.dart';

class BuscarPersonajes extends SearchDelegate {
  final _apiProvider = ApiProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Este metodo funciona para poner Widgets del lado derecho del buscador
    return [IconButton(icon: Icon(Icons.delete), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Sirve para poner un widget al lado izquierdo
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    // xd
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Cada cosa que escribamos en el buscador se ejecutara esta funcion
    return (query != '')
        ? FutureBuilder(
            future: _apiProvider.personajePorIdoNombre(query),
            builder: (BuildContext context, AsyncSnapshot<ApiModel> snapShot) {
              final personajes = snapShot.data;
              if (snapShot.hasData) {
                return ListTile(
                  onTap: () => Navigator.pushNamed(context, '/personajes',
                      arguments: personajes),
                  leading: Image.network(personajes!.image!),
                  title: Text(personajes.name!),
                  subtitle: Text(personajes.id.toString()),
                );
              } else {
                return Image.asset('assets/cargando.gif');
              }
            },
          )
        : Container();
  }
}
