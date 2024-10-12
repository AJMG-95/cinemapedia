import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  //* Se llama al datasorce para que este llame a los métodos (la clase padre/abstracta)
  final MoviesDatasource datasource;
  //Creo el constructor pasandole el datasource como una argumento posicional, porque
  // no se espra recibir más de un datasource, en caso contrario si merecería mas la pena pasarlo
  // como un argumento por nombre -> {required this.datasource}
  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasource.getUpComing(page: page);
  }
}
