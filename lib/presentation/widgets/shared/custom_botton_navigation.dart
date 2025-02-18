import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//! `CustomBottomNavigation`: Barra de navegación inferior personalizada.
//? Esta barra permite navegar entre diferentes secciones de la aplicación usando `GoRouter`.
//? Está diseñada para mantener la consistencia en la UI y proporcionar una experiencia fluida de navegación.
class CustomBottonNavigation extends StatelessWidget {
  const CustomBottonNavigation({super.key});

  //! Método que obtiene el índice actual en función de la ruta activa.
  //? Se usa `GoRouterState.of(context).uri.toString()` para obtener la ruta actual y determinar qué pestaña está seleccionada.
  //? Devuelve un número (`int`) que representa el índice de la pestaña activa en el `BottomNavigationBar`.
  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0; // Si no coincide con ninguna, vuelve a `Inicio`.
    }
  }

  //! Método que maneja el evento `onTap` en la barra de navegación.
  //? Este método cambia la ruta de la aplicación usando `context.go()` según el índice seleccionado.
  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/'); // Navega a la página de Inicio.
        break;
      case 1:
        context.go('/categories'); // Navega a la página de Categorías.
        break;
      case 2:
        context.go('/favorites'); // Navega a la página de Favoritos.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0, // Se elimina la sombra para una apariencia más limpia.

      //! `currentIndex`: Define qué pestaña está seleccionada según la ruta actual.
      currentIndex: getCurrentIndex(context),

      //! `onTap`: Maneja la navegación cuando el usuario toca una pestaña.
      onTap: (value) => onItemTap(context, value),

      items: const [
        //! `BottomNavigationBarItem`: Elemento individual en la barra de navegación.
        //? Cada ícono representa una sección de la aplicación.
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Categorías'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: 'Favoritos'),
      ],
    );
  }
}
