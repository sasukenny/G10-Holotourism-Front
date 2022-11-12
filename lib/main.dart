import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/pages/welcome.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/register_page.dart';

import 'blocs/lugarbloc/lugarbloc_bloc.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider(
      create: (context) => LugarblocBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to HoloTourism ',
        theme: ThemeData(primaryColor: Colors.blue),
        home: welcome(),
        routes: {
          RegisterPage.routeName: (_) => RegisterPage(),
          LoginPage.routeName: (_) => LoginPage(),
        },
      ),
    );
  }
}
