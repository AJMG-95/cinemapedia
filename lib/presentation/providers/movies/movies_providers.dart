// Este archivo va a integrar todos los providers relacionados con  las movies

// Se crea una clase que permita la reutilización de la misma, unicamente cambiendo el
//  caso de uso (usecase: que sería la forma en la que se va a pedir la información)

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este nowPlayingMoviesProvider, me va a ayudar a obtener las peliculas que se encuentran
//  en las carteleras de los cines
// * State_Notifier_Provider -> es un provedor de información que notifica cuando se cambia el estado
// Se indica que el StateNotifierProvider (nowPlayingMoviesProvider) es controlado por el
//  StateNotifier (MoviesNotifier) y que a través de el fluye un dato/estado(state) de tipo List<Movie>
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // Esto guarda una referencia a la funcion del movieRepositoryProvider (movie_repository_provider.dart),
  //  que me devuelve el future de un listado de peliculas.
  // Y es esta referencia la que tengo que pasar como argumento al MoviesNotifier para que pueda ejecuttar
  //  el loadNexPage.
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  // Retorna una instacia del StateNotifier(MoviesNotifier)
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});


final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});


final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComing;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});


final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});



// Se define un "caso de uso" para indicar al MoviesNotifier, que función va a recibir para
//  cargar las siguientes películas. De esta forma se limita el StateNotifier a un unico
//  provider, sino que sea reutilizable con distintos providers
typedef MovieCallBack = Future<List<Movie>> Function({int page});

// El StateNotifier pide el tipo de estado que se va a mantener/manejar (listado de peliculas(entidad) -> <List<Movie> )
class MoviesNotifier extends StateNotifier<List<Movie>> {
  // Este el statenotifier se puede usar para guardar la página actual
  int currentPage = 0;
  bool isLoading =
      false; // Bandera para controlar la carga de las página en el loadNexPage
  MovieCallBack fetchMoreMovies;

  // Estado inicial
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    //Idealmente siempre se va a querer crear un nuevo estado y asignarle el nuevo valor al
    // estado actual (se sobre escribe el estado anterior), en lugar de modificar el anterior,
    // para que el StateNotifier sepa que hubo un cambio
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    // Usa el operador expread para regresar el esatdo actual + todas las nuevas películas
    state = [...state, ...movies];
    await Future.delayed(const Duration(microseconds: 300));
    isLoading = false;
  }
}
