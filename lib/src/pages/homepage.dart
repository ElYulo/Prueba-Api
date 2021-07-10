import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebaapi/src/models/api_models.dart';
import 'package:pruebaapi/src/providers/api_state.dart';
import 'package:pruebaapi/src/buscar/buscarPersonaje.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  final _scrollController = ScrollController();
  bool _cargando = false;
  @override
  void initState() {
    final perState = Get.put(PerState());
    perState.obtenerPersonajes();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (_cargando == false) {
          setState(() {
            _cargando = true;
          });
          await perState.obtenerPersonajes();
          setState(() {
            _cargando = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Personajes de RICK and Morti',
            style: TextStyle(color: Colors.white)),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                _ImgFondo(),
                _Tarjetas(_scrollController),
                if (_cargando == true)
                  Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 10.0,
                    ),
                  )
                else
                  Container(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(context: context, delegate: BuscarPersonajes());
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.black26,
        splashColor: Colors.green[600],
      ),
    );
  }
}

class _Tarjetas extends StatelessWidget {
  final ScrollController _scrollController;
  _Tarjetas(this._scrollController);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerState>(builder: (PerState perState) {
      return GridView.builder(
        controller: _scrollController,
        itemCount: perState.personajes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.8,
        ),
        itemBuilder: (BuildContext context, int i) {
          final _personajes = perState.personajes[i];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/personajes',
                arguments: _personajes),
            child: Container(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _CardPersonajes(_personajes),
                  _ImagenPersonajes(_personajes),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class _ImagenPersonajes extends StatelessWidget {
  final ApiModel _personajes;
  _ImagenPersonajes(this._personajes);
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Positioned(
      right: _mediaQuery.width * -0.0001,
      bottom: _mediaQuery.width * -0.0001,
      child: Container(
        child: FadeInImage(
            fit: BoxFit.cover,
            height: _mediaQuery.width * 0.20,
            placeholder: AssetImage('assets/cargando.gif'),
            image: NetworkImage(_personajes.image!)),
      ),
    );
  }
}

class _CardPersonajes extends StatelessWidget {
  final ApiModel _personajes;
  _CardPersonajes(this._personajes);
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: _mediaQuery.width * 0.55,
      width: double.infinity,
      child: Card(
        color: Colors.black12,
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Positioned(
                bottom: _mediaQuery.width * -0.10,
                child: Image.asset(
                  'assets/letras.png',
                  height: _mediaQuery.width * 0.25,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _personajes.name!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: _mediaQuery.width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    '# ${_personajes.id}',
                    style: TextStyle(
                        fontSize: _mediaQuery.width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImgFondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Positioned(
      child: Center(
        child: Container(
          child: Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              height: _mediaQuery.height * 0.60,
            ),
          ),
        ),
      ),
    );
  }
}
