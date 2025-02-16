//* 📌 Punto de entrada principal de la aplicación Flutter
//? Este archivo `main.dart` es esencial, pero debe mantenerse limpio y libre de sobrecarga.
//? Su única responsabilidad es inicializar la aplicación y definir la configuración base.

import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart'; // Configuración de rutas
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Manejo de variables de entorno

import 'package:cinemapedia/config/theme/app_theme.dart'; // Tema global de la app
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Manejo de estado con Riverpod

///! `main()`: Función principal que inicia la aplicación.
///? Se encarga de cargar las variables de entorno y ejecutar `runApp()`.
Future<void> main() async {
  //* 🔹 Carga de variables de entorno desde `.env`
  await dotenv.load(fileName: ".env");

  //* 🔹 Inicialización de la aplicación con `ProviderScope`
  //! Riverpod exige que el `runApp` esté envuelto en un `ProviderScope`
  //! para poder manejar el estado global de los providers.
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

///! `MainApp`: Widget principal de la aplicación.
///? Contiene la configuración global, como rutas, tema y opciones de depuración.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //* 📌 `routerConfig`: Configuración de las rutas de la aplicación.
      //? Se define en `app_router.dart` para mantener `main.dart` limpio.
      routerConfig: appRouter,

      //* 📌 `debugShowCheckedModeBanner`: Oculta la etiqueta de debug en la app.
      debugShowCheckedModeBanner: false,

      //* 📌 `theme`: Define el tema global de la aplicación.
      //? La configuración completa se encuentra en `app_theme.dart`.
      theme: AppTheme().getTheme(),
    );
  }
}
