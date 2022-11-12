// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  group('initialhome navigation tests', () {
    late NavigatorObserver mockObserver;

    // Crear mock para navegacion
    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildWelcomePage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: InitialHomePage(token: '',),
        navigatorObservers: [mockObserver],
        routes: {
          LoginPage.routeName: (_) => LoginPage(),
          RegisterPage.routeName: (_) => RegisterPage(),
        },
      ));

    }

    testWidgets('Verificar que el boton Galeria exista y redirecciona al ser presionado', (WidgetTester tester) async {
      // Crear mock para navegacion
      await _buildWelcomePage(tester);

      // Buscar los widgets necesarios
      final galeriaButton = find.byKey(const ValueKey("Galería"));

      await tester.tap(galeriaButton);
      await tester.pumpAndSettle(); // buffer para limpiar el test

      // Verificar resultados
      expect(find.byType(MyHomePage), findsOneWidget); // Verificar redireccion
    });

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
