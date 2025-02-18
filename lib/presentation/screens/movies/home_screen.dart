//* 📌 Pantalla principal `HomeScreen` de la aplicación
//? Este archivo define la estructura y el comportamiento de la vista principal.
//? Incluye el `AppBar`, una lista de películas organizadas en distintas categorías
//? y un `BottomNavigationBar` personalizado.

import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';

///! `HomeScreen`: Pantalla principal de la aplicación.
///? Contiene la barra de navegación inferior y el `HomeView` con las películas.
class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  final int pageIndex;

  final viewRoutes = const <Widget> [
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  const HomeScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //! IndexedStack es in widget que sirve para preservar el estado del widget
        child: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
      ),
      bottomNavigationBar: CustomBottonNavigation(currentIndex: pageIndex),
    );
  }
}
