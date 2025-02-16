import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

///! Implementación de la interfaz `MoviesRepository`.
///? Esta clase actúa como un intermediario entre la capa de datos (`MoviesDatasource`)
///? y la capa de dominio, delegando las llamadas a la fuente de datos específica.
class MoviesRepositoryImpl implements MoviesRepository {
  //* Instancia de `MoviesDatasource`, encargada de obtener los datos de películas.
  //* Se usa la clase padre/abstracta, y esta se encarga de llamar a los métodos.
  final MoviesDatasource datasource;

  ///! Constructor de `MoviesRepositoryImpl`.
  ///? Recibe una instancia de `MoviesDatasource` como argumento posicional, ya que solo
  ///? se espera manejar un único datasource. Si en el futuro se necesitara más de un
  ///? datasource, podría ser recomendable pasarlo como un argumento con nombre.
  MoviesRepositoryImpl(this.datasource);

  ///! Obtiene la lista de películas en cartelera (`Now Playing`).
  ///? Este método delega la llamada al método `getNowPlaying` del datasource.
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  ///! Obtiene la lista de películas más populares.
  ///? La consulta se realiza a través del método `getPopular` del datasource.
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  ///! Obtiene la lista de películas mejor valoradas (`Top Rated`).
  ///? Se delega la llamada al método `getTopRated` del datasource.
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  ///! Obtiene la lista de próximas películas a estrenarse (`Upcoming`).
  ///? Se llama al método `getUpComing` del datasource para obtener los datos.
  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasource.getUpComing(page: page);
  }

  ///! Obtiene los detalles de una película específica a partir de su `id`.
  ///? Se delega la llamada al método `getMovieById` del datasource.
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  ///! Realiza una búsqueda de películas basándose en un `query`.
  ///? Se usa el método `searchMovies` del datasource para obtener los resultados.
  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }
}
