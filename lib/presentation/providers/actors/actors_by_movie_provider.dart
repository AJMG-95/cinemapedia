//* 📌 Proveedor para gestionar los actores de las películas en la aplicación
//? Este archivo crea un provider que almacena en caché los actores de cada película
//? y evita hacer múltiples llamadas innecesarias a la API.

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///! `actorsByMovieProvider`: Proveedor de estado (`StateNotifierProvider`)
///? que gestiona la caché de los actores por película.
/// 🔹 Se almacena un mapa donde la clave es el `id` de la película y el valor es una lista de actores.
/// 🔹 Si una película ya tiene actores cargados, se devuelven sin hacer otra petición.
/// 🔹 Si los actores aún no están cargados, se solicitan y se almacenan en la caché.

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(
    getActors: actorsRepository.getActorsByMovie,
  );
});

/*
📌 Estructura del estado que se manejará en el `ActorsByMovieNotifier`:
{
  '123': List<Actor>,  // Lista de actores de la película con id "123"
  '113': List<Actor>,  // Lista de actores de la película con id "113"
  '143': List<Actor>,  // Lista de actores de la película con id "143"
}
*/

///! `GetActorsCallback`: Callback que define la función que obtiene actores de una película.
///? Recibe el `id` de una película como `String` y devuelve una lista de actores (`List<Actor>`).
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

///! `ActorsByMovieNotifier`: Clase que gestiona la caché de los actores por película.
///? Extiende `StateNotifier<Map<String, List<Actor>>>` para almacenar un mapa de actores.
/// 🔹 Si los actores de una película ya están en la caché, los devuelve directamente.
/// 🔹 Si los actores no están cargados, realiza la petición y los guarda en el estado.
/// 🔹 Evita hacer múltiples peticiones innecesarias al backend.

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors; // Callback para obtener los actores.

  ///? Constructor que inicializa el estado vacío `{}` y recibe el callback `getActors`.
  ActorsByMovieNotifier({required this.getActors}) : super({});

  ///! `loadActors`: Método para cargar los actores de una película.
  ///? Verifica si los actores de la película ya están en el estado antes de hacer la petición.
  Future<void> loadActors(String movieId) async {
    // ✅ Si los actores de la película ya están cargados, no hace nada.
    if (state[movieId] != null) return;

    // 🔄 Obtiene los actores desde la API.
    final List<Actor> actors = await getActors(movieId);

    // ✅ Actualiza el estado con los nuevos actores, manteniendo los datos previos.
    state = {...state, movieId: actors};
  }
}
