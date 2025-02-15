// Este es el provider de la vista detalle de las peliculas
// Se va a crear una clase que sirve para mantener en cache las pelicilas ya consultadas

import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

// Hay que indicar el tipado para que riverpod sepa el tipo de datos que usa el MovieMapNotifier
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(
      getMovie: movieRepository
          .getMovieById); // envía la referencia a la función siun llamarla
});

/*
Esto va a crear un mapa 'id':Movie(), y ese mapa se va a recorrer en cada llamada,
 si el id existe ya se sabe que pelicula devolver si no existe se solicita a la api
 y se aña del al mapa
 {
  '123': Movie(),
  '113': Movie(),
  '143': Movie(),
 }
 */

// Crea un callback que regrese una pelicula
typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  //Constructor de la clase (Notifier)
  MovieMapNotifier({required this.getMovie}) : super({});

  //Método que va a llamar la implementacion de la funcion que trae la pelicula
  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) {
      return; // Si la pelicula ya está cargada en el state no regresa nada
    }

    final movie = await getMovie(movieId);

    // No es que se actualice el estado sino que se genera uno nuevo
    //  usando el estado anterior y añadiendo el movieId que apunta a la movie
    state = {...state, movieId: movie};
  }
}
