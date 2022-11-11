import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lugarbloc/lugarbloc_bloc.dart';
import '../screens/home_screen.dart';
import '../widgets/home_list.dart';


const topColor = Color(0xFF00ac83);

class MyHomePage extends StatefulWidget {
  String token;
  MyHomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  late final List<bool> _selections;
  @override
  void initState() {
    _selections = [false, true];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset("assets/logohastalqso.png", fit: BoxFit.cover, height: 60, width: 70),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
          }),
        actions: <Widget>[
        ToggleButtons(
          isSelected: _selections,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selections.length; i++) {
                _selections[i] = i == index;
                debugPrint('movieTitle: $_selections');
              }
            });
          },
          fillColor: const Color(0xFF0FF2BC),
          splashColor: const Color(0xFF0FF2BC),
          children: const [
            Icon(Icons.format_list_bulleted),
            Icon(Icons.grid_view_sharp)
          ],
        )
        ],
        backgroundColor: topColor,
      ),
      body: BlocBuilder<LugarblocBloc, LugarblocState>(
        builder: (context, state) {
          if (state is LugarblocStarted){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 60),
                  Text.rich(TextSpan(
                      text: "¿Aún no sube ninguna imagen?",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  Text.rich(TextSpan(
                      text: "¡Haga click en el signo '+' para iniciar!",
                      style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
            );
          }
          if (state is LugarblocLoaded){
            return CustomList(
              selections: _selections,
              touristicPlaces: state.lugarTuristicos,
            );
          }
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeScreenDialogs().build(context);
        },
        backgroundColor: topColor,
        tooltip: 'Upload Image',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


