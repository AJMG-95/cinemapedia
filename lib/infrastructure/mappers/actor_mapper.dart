import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity( Cast cast ) =>
    Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != '' && cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://www.limestone.edu/sites/default/files/styles/d06_square/public/images/2019-11/user.jpg?h=4c55e9d8&itok=oyoJ2tsc',
      character: cast.character
    );
}
