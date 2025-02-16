//* El objetivo del `MovieMapper` es convertir diferentes modelos de datos en entidades `Movie`
//* usadas dentro de la aplicación. Este mapeador toma los modelos de respuesta de la API
//* (`MovieMovieDB` y `MovieDetails`) y los transforma en una entidad `Movie` para uso interno.

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  ///! Convierte un `MovieMovieDB` (modelo de respuesta de la API) en una entidad `Movie`.
  ///? Esta función transforma los datos del modelo JSON en un objeto `Movie`, asegurando
  ///? que los valores sean válidos y proporcionando valores por defecto cuando sea necesario.
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: moviedb.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/9556d16312333.5691dd2255721.jpg',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: moviedb.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://lascrucesfilmfest.com/wp-content/uploads/2018/01/no-poster-available-737x1024.jpg',
        releaseDate: moviedb.releaseDate ?? DateTime(2000, 1, 1),
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  ///! Convierte un `MovieDetails` (modelo de detalles de la API) en una entidad `Movie`.
  ///? Similar a `movieDBToEntity`, pero con más información específica sobre la película.
  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: moviedb.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/9556d16312333.5691dd2255721.jpg',
        genreIds: moviedb.genres.map((e) => e.name).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: moviedb.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://cdn1.vectorstock.com/i/1000x1000/76/90/not-found-rubber-stamp-vector-13537690.jpg',

        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );
}
