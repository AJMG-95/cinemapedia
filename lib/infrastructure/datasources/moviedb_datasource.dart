import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'es-ES',
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Recoge la respues desde la api
    final response = await dio.get('/movie/now_playing');
    //Obtine el modelo (MovieDbResponse) a partir del json de la respuesta
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    //Mapea el modelo y lo transforma en una lista de entidades (Movie)
    /*
    final List<Movie> movies = movieDBResponse.results
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    */
    //* Las listas se pueden filtrar usando el método where
    // En este caso se filtrran para no dejar pasar las peliculas que no tengan poster
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    // Devuelve la list<Movie>
    return movies;
  }
}
