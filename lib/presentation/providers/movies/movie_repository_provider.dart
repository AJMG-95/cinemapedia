//* Este archivo crea la instancia del repository

// Como esto va a ser un provider que no se va a modificar (inmutable), entidase como
//  tal que el estado/datos que contiene nunca cambiar, y por ello se puede crear
//  de/para solo lectura
// EL objetico de esta clase es proporcionar el MoviesRepositoryImpl de manera global,
//  para que cualquier otro provider tenga acceso a esa información

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';

// Como es de solo lectura se usa el tipo/método Provier
final movieRepositoryProvider = Provider((ref) {
  // Este provider debe devolver la implemetación del repository y este
  //  repository pide que se le pase como argumentro el datasource, que es el origen de datos
  //  de la aplicació, por lo que se le pasa la implementación específica de lo que se va a
  //  necesitar para extraer la infromación
  return MoviesRepositoryImpl( MoviedbDatasource() ) ;
});
