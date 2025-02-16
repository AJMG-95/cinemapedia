//* Este archivo define el `movieRepositoryProvider`, el cual proporciona una instancia del repositorio de películas (`MoviesRepositoryImpl`).
//? Este provider es inmutable, es decir, sus datos no cambian una vez inicializados.
//? Su propósito principal es centralizar la creación del repositorio y hacerlo accesible de forma global en la aplicación.
/* Clase Provider => (Solo lectura) */

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';

///! `movieRepositoryProvider`: Proveedor de solo lectura (`Provider`).
///? Devuelve una única instancia de `MoviesRepositoryImpl`, asegurando que toda la app use la misma instancia del repositorio.
///? Cualquier provider que necesite acceder a datos de películas puede leer este provider para obtener el repositorio.
final movieRepositoryProvider = Provider((ref) {
  //* Se instancia `MoviesRepositoryImpl`, el cual requiere un `MoviesDatasource` como fuente de datos.
  //* En este caso, se le pasa `MoviedbDatasource()`, que es la implementación concreta para obtener datos desde TheMovieDB.
  return MoviesRepositoryImpl(MoviedbDatasource());
});
