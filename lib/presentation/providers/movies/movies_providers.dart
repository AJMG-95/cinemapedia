//? Este archivo centraliza todos los providers relacionados con la obtención de películas en la aplicación.
//? Se usa `StateNotifierProvider` para manejar y notificar los cambios de estado en la lista de películas.

//* Se crea una clase (`MoviesNotifier`) que permitirá la reutilización del código,
//* permitiendo cambiar solo la función de carga de datos (`fetchMoreMovies`).
//* Esto hace que el `StateNotifier` sea reutilizable para diferentes tipos de películas (cartelera, populares, etc.).

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///! Proveedor que obtiene las películas en cartelera (`Now Playing`).
///? Usa `StateNotifierProvider` para gestionar la lista de películas y notificar cambios.
/*
  <MoviesNotifier, List<Movie>> indica que el nowPlayingMoviesProvider es controlador por
  MoviesNotifier(StateNotifier) y que a través de el fluye un dato/stado(state) de tipo
  List<Movie>
*/
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //* Se obtiene la referencia al método `getNowPlaying` del `movieRepositoryProvider` que me devuelve el future de un listado de peliculas
  /*
    Es esta referencia la que tengo que pasar como argumento al MoviesNotifier
    para que pueda ejecuttar el loadNexPage.
  */
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  //* Se retorna una instancia de `MoviesNotifier` con la función específica para obtener las películas en cartelera.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

///! Proveedor que obtiene las películas más populares (`Popular`).
final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

///! Proveedor que obtiene las películas próximas a estrenarse (`Upcoming`).
final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComing;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

///! Proveedor que obtiene las películas mejor valoradas (`Top Rated`).
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

///! Definición de un tipo de función (`typedef`) que representa la función para cargar más películas.
///? Esto permite reutilizar `MoviesNotifier` con diferentes fuentes de datos.
typedef MovieCallBack = Future<List<Movie>> Function({int page});

///! Clase `MoviesNotifier` que gestiona el estado de la lista de películas.
///? Extiende `StateNotifier<List<Movie>>` para manejar el estado de las películas y notificar cambios.
class MoviesNotifier extends StateNotifier<List<Movie>> {
  //* Página actual que se está cargando.
  int currentPage = 0;

  //* Bandera para evitar múltiples cargas simultáneas.
  bool isLoading = false;

  //* Callback que define cómo se obtienen más películas.
  /*
    Este Callback sirve para indicar al MoviesNotifier(StateNotifier), que función va a
    recibir para cargar las siguientes películas. De esta forma NO se limita el
    StateNotifier a un unico provider, sino que será reutilizable con distintos providers.
  */
  final MovieCallBack fetchMoreMovies;

  ///! Constructor de `MoviesNotifier`.
  ///? Recibe la función `fetchMoreMovies` como argumento requerido.
  ///? Inicializa el estado con una lista vacía de películas (`super([])`).
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  ///! Método que carga la siguiente página de películas.
  ///? Se asegura de no hacer llamadas duplicadas estableciendo `isLoading` como `true`.
  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    //* Se obtiene la nueva lista de películas desde la API.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    //* Se actualiza el estado con las nuevas películas sin perder las ya cargadas.
    /*
      Siempre se va a querer crear un nuevo estado y asignarle el nuevo valor al estado actual,
      (se sobre escribe el estado anterior). En lugar de modificar el anterior, para que
      el StateNotifier sepa que hubo un cambio de estado.
    */
    state = [...state, ...movies];

    //* Se espera un pequeño tiempo antes de permitir otra carga para evitar recargas innecesarias.
    await Future.delayed(const Duration(milliseconds: 300));

    isLoading = false;
  }
}
