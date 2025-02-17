import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! `searchQueryProvider` almacena el término de búsqueda actual.
//? Se usa `StateProvider<String>` porque es un estado simple y reactivo que solo contiene un `String`.
//? Este provider permite que el término de búsqueda persista y sea reutilizado en la aplicación.
final searchQueryProvider = StateProvider<String>((ref) => '');

//! `searchedMovieProvider`: Mantiene en caché las películas obtenidas en la última búsqueda.
//? Almacena una lista de `Movie`, lo que evita hacer nuevas peticiones innecesarias
//? cuando el usuario regresa a la búsqueda anterior.

//? `StateNotifierProvider` es necesario porque este provider mantiene un estado que puede cambiar
//? dinámicamente al realizar nuevas búsquedas.
final searchedMoviesProvider =
    StateNotifierProvider<SearchedMovieNotifier, List<Movie>>((ref) {
  //! Se obtiene el `movieRepository` desde `movieRepositoryProvider`.
  //? `ref.read()` es usado en lugar de `ref.watch()` porque no se necesita reconstruir el provider cada vez que cambia.
  final movieRepository = ref.read(movieRepositoryProvider);

  //! Se instancia `SearchedMovieNotifier` y se le pasa la función `searchMovies` del `movieRepository`
  //? También se pasa `ref` para que `SearchedMovieNotifier` tenga acceso a otros providers.
  return SearchedMovieNotifier(
      searchMovies: movieRepository.searchMovies, ref: ref);
});


//! `SearchMoviesCallback`: Un `typedef` para definir el tipo de función de búsqueda de películas.
//? Permite estandarizar la función que recibe una `query` (`String`) y devuelve un `Future<List<Movie>>`.
//? Esto ayuda a desacoplar la lógica de búsqueda, facilitando el uso de distintas implementaciones si es necesario.
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

//! `SearchedMovieNotifier`: Clase que gestiona el estado de las películas buscadas.
//? `StateNotifier<List<Movie>>` se usa para manejar un estado dinámico y notificar a los listeners cuando cambia.
//? Cada vez que se realiza una nueva búsqueda, el estado se actualiza con los resultados.
class SearchedMovieNotifier extends StateNotifier<List<Movie>> {
  //! `searchMovies`: Callback que ejecuta la búsqueda en `movieRepository`.
  final SearchMoviesCallback searchMovies;

  //! `ref`: Referencia a otros providers en Riverpod.
  //? Como `StateNotifier` no tiene acceso directo a `ref`, se pasa en el constructor para poder actualizar otros providers.
  final Ref ref;

  //! Constructor del `SearchedMovieNotifier`.
  //? `super([])` inicializa el estado con una lista vacía de películas.
  SearchedMovieNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);


  //! `searchMoviesByQuery`: Método para ejecutar la búsqueda y actualizar el estado.
  //? Recibe una `query` (el término de búsqueda) y devuelve una `Future<List<Movie>>` con los resultados.
  Future<List<Movie>> searchMoviesByQuery(String query) async {
    //! Se obtiene la lista de películas llamando a `searchMovies(query)`.
    final List<Movie> movies = await searchMovies(query);

    //! Se actualiza el provider `searchQueryProvider` con la nueva query ingresada.
    //? Esto permite que la búsqueda persista y sea reutilizable en otras partes de la app.
    ref.read(searchQueryProvider.notifier).update((state) => query);

    //! Se actualiza el estado con las nuevas películas obtenidas.
    //? No se usa `spread (...)` porque se desea reemplazar completamente la lista con los nuevos resultados,
    //? en lugar de mantener las búsquedas anteriores.
    state = movies;

    //! Retorna la lista de películas obtenidas.
    return movies;
  }
}
