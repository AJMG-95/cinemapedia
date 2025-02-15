// Proveedor de los actores de las peliculas

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(
    getActors: actorsRepository.getActorsByMovie
  );
});


/*
Esto es lo que se va a manejar en el estado
 {
  '123': List<Actor>,
  '113': List<Actor>,
  '143': List<Actor>,
 }
 */


typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;


  ActorsByMovieNotifier({
    required this.getActors
  }) : super({});


  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) {
      return;
    }

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
