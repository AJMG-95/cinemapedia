import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<bool> isMovieInWatchlist(int movieId) {
    return datasource.isMovieInWatchlist(movieId);
  }

  @override
  Future<bool> isMovieWatched(int movieId) {
    return datasource.isMovieWatched(movieId);
  }

  @override
  Future<List<Movie>> loadMovies(
      {String schemaName = 'favorites', int limit = 10, offset = 0}) {
    return datasource.loadMovies(
        schemaName: schemaName, limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }

  @override
  Future<void> toggleWatched(Movie movie) {
    return datasource.toggleWatched(movie);
  }

  @override
  Future<void> toggleWatchlist(Movie movie) {
    return datasource.toggleWatchlist(movie);
  }
}
