// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:holotourismfront/blocs/lugarbloc/lugarbloc_bloc.dart';
import 'package:holotourismfront/presentation/pages/home.dart';
import 'package:holotourismfront/presentation/pages/initialhome.dart';
import 'package:holotourismfront/presentation/pages/login_page.dart';
import 'package:holotourismfront/presentation/pages/register_page.dart';
import 'package:mockito/mockito.dart';
import 'package:holotourismfront/presentation/pages/welcome.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Welcome navigation tests', () {
    late NavigatorObserver mockObserver;

    // Crear mock para navegacion
    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildWelcomePage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: welcome(),
        navigatorObservers: [mockObserver],
        routes: {
          LoginPage.routeName: (_) => LoginPage(),
          RegisterPage.routeName: (_) => RegisterPage(),
        },
      ));

    }

    testWidgets('Verificar que el boton login exista y redirecciona al ser presionado', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildWelcomePage(tester);

      // Buscar los widgets necesarios
      final loginButton = find.byKey(const ValueKey("loginButton"));

      await tester.tap(loginButton);
      await tester.pumpAndSettle(); // buffer para limpiar el test

      // Verificar resultados
      expect(find.byType(LoginPage), findsOneWidget); // Verificar redireccion
    });

    testWidgets('Verificar que el boton register exista y redirecciona al ser presionado', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildWelcomePage(tester);

      // Buscar los widgets necesarios
      final registerButton = find.byKey(const ValueKey("registerButton"));

      await tester.tap(registerButton);
      await tester.pumpAndSettle(); // buffer para limpiar el test

      // Verificar resultados
      expect(find.byType(RegisterPage), findsOneWidget); // Verificar redireccion
    });
  });

// test group 2
// login form
  group('login form tests', () {
    late NavigatorObserver mockObserver;

    // Crear mock para navegacion
    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildLoginPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
        navigatorObservers: [mockObserver],
        routes: {
          LoginPage.routeName: (_) => LoginPage(),
          RegisterPage.routeName: (_) => RegisterPage(),
        },
      ));

    }

    testWidgets('validar boton de texto registrate redirecciona al ser presionado', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildLoginPage(tester);

      // Buscar los widgets necesarios
      final registrateButton = find.byKey(const ValueKey("registrateButton"));

      await tester.tap(registrateButton);
      await tester.pumpAndSettle(); // buffer para limpiar el test

      // Verificar resultados
      expect(find.byType(RegisterPage), findsOneWidget); // Verificar redireccion
    });

    testWidgets('validar boton de olvido Contraseña existe', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildLoginPage(tester);

      // Buscar los widgets necesarios
      final olvidoButton = find.byKey(const ValueKey("olvidoButton"));

      await tester.tap(olvidoButton);
      await tester.pumpAndSettle(); // buffer para limpiar el test

      // Verificar resultados
      expect(find.byType(LoginPage), findsOneWidget); // Verificar redireccion
    });

    testWidgets('validar formulario de login deja escribir', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildLoginPage(tester);

      // Buscar los widgets necesarios
      final entradaEmail = find.byKey(const ValueKey("entradaEmail"));
      final entradaContrasenia = find.byKey(const ValueKey("entradaContrasenia"));


      // Ejecutar test
      await tester.enterText(entradaEmail, "calan");
      await tester.enterText(entradaContrasenia, "zopas");
      await tester.pump(); // buffer para limpiar el test

      // Verificar resultados
      expect(find.text("calan"), findsOneWidget);
      expect(find.text("zopas"), findsOneWidget);
    // Verificar redireccion
    });

    testWidgets('validar boton de Ingresar existe y valida', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildLoginPage(tester);

      final ingresarButton = find.byKey(const ValueKey("ingresarButton"));


      // Ejecutar test
      await tester.tap(ingresarButton);
      await tester.pump(Duration(seconds:2));
      await tester.pumpAndSettle();// buffer para limpiar el test

      // Verificar resultados
      expect(find.text("Email incorrecto"), findsOneWidget);
      expect(find.text("Contraseña inválida"), findsOneWidget);
      // Verificar redireccion
    });

    testWidgets('validar e-mail', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildLoginPage(tester);

      // Buscar los widgets necesarios
      final entradaEmail = find.byKey(const ValueKey("entradaEmail"));
      final ingresarButton = find.byKey(const ValueKey("ingresarButton"));

      // Ejecutar test
      await tester.enterText(entradaEmail, "calan");
      await tester.tap(ingresarButton);
      await tester.pump(Duration(seconds:2));
      await tester.pumpAndSettle();// // buffer para limpiar el test

      // Verificar resultados
      expect(find.text("Email incorrecto"), findsOneWidget);
      // Verificar redireccion
    });

    testWidgets('validar contraseña', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildLoginPage(tester);

      // Buscar los widgets necesarios
      final entradaContrasenia = find.byKey(const ValueKey("entradaContrasenia"));
      final ingresarButton = find.byKey(const ValueKey("ingresarButton"));

      // Ejecutar test
      await tester.enterText(entradaContrasenia, "     ");
      await tester.tap(ingresarButton);
      await tester.pump(Duration(seconds:2));
      await tester.pumpAndSettle();// // buffer para limpiar el test

      // Verificar resultados
      expect(find.text("Email incorrecto"), findsOneWidget);
      // Verificar redireccion
    });

    testWidgets('validar que el usuario ingresado esté registrado', (WidgetTester tester) async {
      /// Crear mock para navegacion
      await _buildLoginPage(tester);
      final entradaEmail = find.byKey(const ValueKey("entradaEmail"));
      final entradaContrasenia = find.byKey(const ValueKey("entradaContrasenia"));
      final ingresarButton = find.byKey(const ValueKey("ingresarButton"));


      // Ejecutar test
      await tester.enterText(entradaEmail, "calan@gmail.com");
      await tester.enterText(entradaContrasenia, "siuuuuu");
      await tester.tap(ingresarButton);
      await tester.pump(Duration(seconds:2));
      await tester.pumpAndSettle();// buffer para limpiar el test

      // Verificar resultados
      expect(find.text("Usuario o contraseña incorrecto"), findsOneWidget);

    });
  });

  group('initialhome navigation tests', () {

    testWidgets('Verificar que el boton Galeria exista y redirecciona al ser presionado', (WidgetTester tester) async {
      // Crear mock para navegacion
      await tester.pumpWidget(
          BlocProvider(
            create: (context) => LugarblocBloc(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Welcome to HoloTourism ',
              theme: ThemeData(primaryColor: Colors.blue),
              home: InitialHomePage(token: '123123asdasd',),
              //home: welcome(),
              routes: {
                RegisterPage.routeName: (_) => RegisterPage(),
                LoginPage.routeName: (_) => LoginPage(),
              },
            ),
          ),
      );

      // Buscar los widgets necesarios
      final galeriaButton = find.byKey(const ValueKey("Galería"));

      await tester.tap(galeriaButton);
      await tester.pumpAndSettle(); // buffer para limpiar el test

      // Verificar resultados
      expect(find.byType(MyHomePage), findsOneWidget); // Verificar redireccion
    });
    //
    // testWidgets('Verificar que el boton Destinos exista', (WidgetTester tester) async {
    //   // Crear mock para navegacion
    //   await _buildWelcomePage(tester);
    //
    //   // Buscar los widgets necesarios
    //   final registerButton = find.byKey(const ValueKey("registerButton"));
    //
    //   await tester.tap(registerButton);
    //   await tester.pumpAndSettle(); // buffer para limpiar el test
    //
    //   // Verificar resultados
    //   expect(find.byType(RegisterPage), findsOneWidget); // Verificar redireccion
    // });
    //
    // testWidgets('Verificar que el boton Mis rutas exista', (WidgetTester tester) async {
    //   // Crear mock para navegacion
    //   await _buildWelcomePage(tester);
    //
    //   // Buscar los widgets necesarios
    //   final registerButton = find.byKey(const ValueKey("registerButton"));
    //
    //   await tester.tap(registerButton);
    //   await tester.pumpAndSettle(); // buffer para limpiar el test
    //
    //   // Verificar resultados
    //   expect(find.byType(RegisterPage), findsOneWidget); // Verificar redireccion
    // });
  });
}
