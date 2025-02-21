import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
 Future<void> toggleFavorite(Movie movie);
 Future<void> toggleWatched(Movie movie);
 Future<void> toggleWatchlist(Movie movie);

 Future<bool> isMovieFavorite(int movieId);
 Future<bool> isMovieWatched(int movieId);
 Future<bool> isMovieInWatchlist(int movieId);

 Future<List<Movie>> loadMovies(
   {String schemaName = 'favorites', int limit = 10, offset = 0});
}
