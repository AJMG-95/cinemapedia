
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
 Future<void> toggleFavorite(Movie movie);

 Future<bool> isMovieFavorite(int movieId);

 Future<List<Movie>> loadMovies(
  {String schemaName = 'favorites', int limit = 10, offset = 0});
}
