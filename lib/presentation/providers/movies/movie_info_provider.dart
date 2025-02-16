//* Este es el provider para la vista de detalles de las películas.
//? Su objetivo es almacenar en caché las películas que ya han sido consultadas
//? para evitar múltiples llamadas innecesarias a la API y mejorar el rendimiento.

import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

///! `movieInfoProvider`: Proveedor que maneja un mapa (`Map<String, Movie>`) donde
///! la clave es el ID de la película y el valor es la entidad `Movie`.
///? Riverpod necesita conocer el tipo de datos que manejará el `StateNotifier`,
///? por eso se especifica `Map<String, Movie>`.
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  // Se obtiene una referencia al repositorio de películas
  final movieRepository = ref.watch(movieRepositoryProvider);

  // Se instancia `MovieMapNotifier`, pasándole como argumento el método `getMovieById`
  // del repositorio, sin ejecutarlo todavía.
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

/*
  📝 Explicación del almacenamiento en caché:
  Se crea un mapa `Map<String, Movie>` donde:
  - La clave es el `id` de la película.
  - El valor es la instancia de `Movie` correspondiente.

  📌 Funcionamiento:
  1️⃣ Cuando se solicita una película, primero se revisa si ya está almacenada en el mapa.
  2️⃣ Si está en caché, se devuelve sin hacer una nueva petición.
  3️⃣ Si no está en caché, se consulta a la API, se almacena en el mapa y luego se devuelve.

  🔹 Ejemplo de estructura del mapa en memoria:
  {
    '123': Movie(), // Película con ID 123 ya consultada
    '113': Movie(), // Película con ID 113 ya consultada
    '143': Movie(), // Película con ID 143 ya consultada
  }
*/

///! `GetMovieCallback`: Callback que recibe un `String` (ID de película)
///! y devuelve un `Future<Movie>`, permitiendo inyectar diferentes fuentes de datos.
typedef GetMovieCallback = Future<Movie> Function(String movieId);

///! `MovieMapNotifier`: Clase que gestiona el estado del `movieInfoProvider`.
///? Se encarga de almacenar y recuperar las películas en caché.
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  // Callback para obtener una película por su ID.
  final GetMovieCallback getMovie;

  //* Constructor del `StateNotifier`, inicializa el estado con un mapa vacío (`{}`).
  MovieMapNotifier({required this.getMovie}) : super({});

  ///! `loadMovie`: Método que carga una película en el estado si no está en caché.
  ///? Verifica si la película ya está almacenada antes de hacer una petición a la API.
  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) {
      return; // ✅ Si la película ya está cargada, simplemente retorna sin hacer nada.
    }

    // 🔄 Se obtiene la película desde la API.
    final movie = await getMovie(movieId);

    // 🔄 Se actualiza el estado con una nueva instancia del mapa que incluye la nueva película.
    state = {...state, movieId: movie};
  }
}
