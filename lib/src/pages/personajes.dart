import 'package:flutter/material.dart';
import 'package:pruebaapi/src/models/api_models.dart';

class Personajes extends StatefulWidget {
  createState() {
    return PersonajesState();
  }
}

class PersonajesState extends State<Personajes> {
  int _paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    final ApiModel personajes =
        ModalRoute.of(context)!.settings.arguments as ApiModel;
    final _mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          '${personajes.name!} - ${personajes.species}',
          style: TextStyle(color: Colors.tealAccent),
        ),
      ),
      body: _DatosPersonaje(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        currentIndex: _paginaActual,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined,
                color: Colors.white, size: _mediaQuery.width * 0.10),
            label: 'Localizacion',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv_sharp,
              color: Colors.white,
              size: _mediaQuery.width * 0.10,
            ),
            label: 'Episodios',
          ),
        ],
        backgroundColor: Colors.black,
      ),
    );
  }
}

class _DatosPersonaje extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApiModel personajes =
        ModalRoute.of(context)!.settings.arguments as ApiModel;
    final _mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: _mediaQuery.width * 0.03),
        Text(
          personajes.name!,
          style: TextStyle(
              fontSize: _mediaQuery.width * 0.10, color: Colors.white),
        ),
        _Imgen(),
        SizedBox(height: _mediaQuery.width * 0.02),
        Text('Specie: ${personajes.species!}',
            style: TextStyle(
                fontSize: _mediaQuery.width * 0.04, color: Colors.white)),
        SizedBox(height: _mediaQuery.width * 0.02),
        Text('Gender: ${personajes.gender!}',
            style: TextStyle(
                fontSize: _mediaQuery.width * 0.04, color: Colors.white)),
        SizedBox(height: _mediaQuery.width * 0.02),
        Text('Status: ${personajes.status!}',
            style: TextStyle(
                fontSize: _mediaQuery.width * 0.04, color: Colors.white)),
        SizedBox(height: _mediaQuery.width * 0.02),
        Text('Type: ${personajes.type!}',
            style: TextStyle(
                fontSize: _mediaQuery.width * 0.04, color: Colors.white)),
        SizedBox(height: _mediaQuery.width * 0.06),
        Image.asset(
          'assets/letras.png',
          height: _mediaQuery.width * 0.40,
        ),
      ],
    );
  }
}

class _Imgen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    final ApiModel personajes =
        ModalRoute.of(context)!.settings.arguments as ApiModel;
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: _mediaQuery.width * 0.23,
            backgroundImage: NetworkImage(//imagen del personaje
                personajes.image!),
          ),
        ],
      ),
    );
  }
}
