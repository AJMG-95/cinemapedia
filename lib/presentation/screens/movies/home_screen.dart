//* 📌 Pantalla principal `HomeScreen` de la aplicación
//? Este archivo define la estructura y el comportamiento de la vista principal.
//? Incluye el `AppBar`, una lista de películas organizadas en distintas categorías
//? y un `BottomNavigationBar` personalizado.

import 'package:cinemapedia/presentation/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';

///! `HomeScreen`: Pantalla principal de la aplicación.
///? Contiene la barra de navegación inferior y el `HomeView` con las películas.
class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  final Widget childView;

  const HomeScreen({
    super.key,
    required this.childView,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottonNavigation(),
    );
  }
}
