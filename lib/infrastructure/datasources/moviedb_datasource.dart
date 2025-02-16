import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

///! Implementación de `MoviesDatasource` que obtiene datos desde The Movie Database (TMDb).
///* Usa `Dio` para realizar solicitudes HTTP y obtener información de películas.
///? Convierte los datos obtenidos en `Movie` entities para su uso en la app.
class MoviedbDatasource extends MoviesDatasource {
  //* Cliente HTTP `Dio` configurado con la base de TMDb.
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.theMovieDbBaseUrl, // URL base de la API de TMDb.
      queryParameters: {
        'api_key': Environment.theMovieDbKey, // API Key para autenticación.
        'language': 'es-ES', // Se establece el idioma español por defecto.
      },
    ),
  );

  ///* Convierte la respuesta JSON de TMDb en una lista de entidades `Movie`.
  ///? Recibe un `Map<String, dynamic>` con la respuesta JSON de la API.
  ///? Retorna una lista de `Movie` listas para ser usadas en la aplicación.
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    //? Obtiene el modelo `MovieDbResponse` a partir del JSON de la respuesta.
    final movieDBResponse = MovieDbResponse.fromJson(json);

    //? Filtra y mapea los resultados para convertirlos en `Movie` entities.
    //? Se descartan películas sin `posterPath` válido.
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  //* Obtiene la lista de películas en cartelera (Now Playing).
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page, // Número de página a consultar.
    });

    return _jsonToMovies(response.data);
  }

  //* Obtiene la lista de películas populares.
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  //* Obtiene la lista de películas mejor valoradas (Top Rated).
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  //* Obtiene la lista de próximas películas (Upcoming).
  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  //* Obtiene los detalles de una película por su ID.
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    // Si el estado de respuesta no es 200, lanza una excepción.
    if (response.statusCode != 200) throw Exception('Movie with id: $id not found');

    // Convierte la respuesta en un modelo `MovieDetails` y luego en una entidad `Movie`.
    final movieDBDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDBDetails);

    return movie;
  }

  //* Realiza una búsqueda de películas por título o palabras clave.
  @override
  Future<List<Movie>> searchMovies(String query) async {
    // Si el query está vacío, retorna una lista vacía.
    if (query.isEmpty) return [];

    final response = await dio.get(
      '/search/movie',
      queryParameters: {
        'query': query, // Parámetro de búsqueda enviado a la API.
      },
    );

    return _jsonToMovies(response.data);
  }
}
