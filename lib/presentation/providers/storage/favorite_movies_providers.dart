import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///! `favoriteMoviesProvider`
///* Este `StateNotifierProvider` gestiona la lista de películas favoritas del usuario en la aplicación.
///*
/*
? `StateNotifierProvider`:
  - Es un provider que maneja el estado con un `StateNotifier`.
  - Permite actualizar y gestionar el estado de manera eficiente.
  - `StorageMoviesNotifier` es el encargado de manejar este estado.
*/
///* - `ref.watch(localStorageRepositoryPrivder)`: Obtiene el repositorio de almacenamiento local.
final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryPrivder);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

///! `StorageMoviesNotifier`
///* Este `StateNotifier` gestiona el estado de las películas favoritas en un mapa (`Map<int, Movie>`).
///*
/*
? `StateNotifier<Map<int, Movie>>`:
  - Maneja el estado como un mapa donde la clave es el `id` de la película y el valor es la película misma.
  - Permite la actualización eficiente del estado sin recrear instancias innecesarias.
*/
class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0; //! Número de página para la paginación.

  final LocalStorageRepository localStorageRepository;

  ///* Constructor de `StorageMoviesNotifier`
  /// - Recibe el `localStorageRepository` para manejar el almacenamiento local.
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  ///! `loadNextPage`
  ///* Carga la siguiente página de películas favoritas desde el almacenamiento local.
  /// - Se carga un lote de 10 películas por página.
  /// - Se actualiza `state` con las nuevas películas obtenidas.
  Future<List<Movie>> loadNexPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    final tempMoviesMap = <int, Movie>{};

    for (final movie in movies) {
      tempMoviesMap[movie.id] =
          movie; //! Se agrega cada película al mapa temporal con su ID como clave.
    }

    state = {
      ...state,
      ...tempMoviesMap
    }; //! Se actualiza el estado con las nuevas películas.

    return movies;
  }
}
