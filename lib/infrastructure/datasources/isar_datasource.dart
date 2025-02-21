import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';

///! Clase `IsarDatasource`
/// Esta clase implementa `LocalStorageDatasource` y gestiona el almacenamiento
/// local de las películas favoritas utilizando la base de datos Isar.
class IsarDatasource extends LocalStorageDatasource {
  ///? `db` es una instancia futura de Isar que almacena la base de datos local.
  late Future<Isar> db;

  ///* Constructor
  /// Inicializa la base de datos llamando a `openDB()`.
  IsarDatasource() {
    db = openDB();
  }

  ///! Método `openDB`
  ///* Abre o recupera una instancia de la base de datos Isar.
  ///* Si no hay ninguna instancia abierta, la crea y la almacena en el directorio de documentos.
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir =
          await getApplicationDocumentsDirectory(); //? Obtiene el directorio donde se almacenará la BD.
      return await Isar.open([MovieSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(
        Isar.getInstance()); //? Retorna la instancia existente de la BD.
  }

  ///! Método `isMovieFavorite`
  ///* Comprueba si una película está marcada como favorita en la base de datos.
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isFavoriteMovie !=
        null; //? Retorna `true` si la película existe en la BD, `false` en caso contrario.
  }

  ///! Método `toggleFavorite`
  ///* Añade o elimina una película de la lista de favoritos.
  /// Si la película ya está en favoritos, la elimina.
  /// Si no está, la añade.
  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      //! Eliminar película de favoritos
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    //* Agregar película a favoritos
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  ///! Método `loadMovies`
  ///* Carga una lista de películas desde la base de datos.
  /// - `limit`: Cantidad máxima de películas a recuperar.
  /// - `offset`: Número de registros a saltar.
  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies
        .where()
        .offset(offset)
        .limit(limit)
        .findAll(); //? Retorna una lista de películas.
  }
}
