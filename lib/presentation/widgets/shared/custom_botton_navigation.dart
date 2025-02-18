import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottonNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottonNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext conext, int index) {
        conext.go('/home/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: 'Categorías'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Favoritos')
        ]);
  }
}
