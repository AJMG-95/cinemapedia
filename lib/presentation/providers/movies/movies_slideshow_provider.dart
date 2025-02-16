//* `moviesSlideshowProvider`: Provider que genera una lista de películas para el slideshow.
//? Extrae las primeras 6 películas de `nowPlayingMoviesProvider` y las devuelve como una lista.

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

///! `moviesSlideshowProvider`: Proveedor de solo lectura (`Provider<List<Movie>>`)
///? que obtiene las películas actualmente en cartelera (`nowPlayingMoviesProvider`)
///? y selecciona un subconjunto para el slideshow.
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  // 🔄 Se obtiene la lista de películas en cartelera desde `nowPlayingMoviesProvider`.
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  // ✅ Si la lista está vacía, se devuelve una lista vacía para evitar errores.
  if (nowPlayingMovies.isEmpty) return [];

  // 🎥 Se seleccionan solo las primeras 6 películas para el slideshow.
  return nowPlayingMovies.sublist(0, 6);
});
