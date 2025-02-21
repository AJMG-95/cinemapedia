import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cinemapedia/domain/entities/favorite_movie.dart';
import 'package:cinemapedia/domain/entities/watched_movie.dart';
import 'package:cinemapedia/domain/entities/watchlist_movie.dart';

class IsarDatasoucer extends LocalStorageDatasource {
 //! `db`: Future que almacena la instancia de la base de datos Isar.
 //? Se inicializa en el constructor llamando a `openDB()`.
 late Future<Isar> db;

 IsarDatasoucer() {
  db = openDB();
 }

 //! `openDB()`: Método encargado de abrir o inicializar la base de datos Isar.
 //? 📌 Este método devuelve un `Future<Isar>` porque la apertura de la base de datos es una operación asíncrona.
 //? 📌 Se asegura de que la base de datos solo se abra una vez y reutiliza la instancia si ya está abierta.
 Future<Isar> openDB() async {
  //! 📌 `getApplicationDocumentsDirectory()` obtiene el directorio donde se almacenará la base de datos.
  //? `path_provider` es la librería utilizada para obtener este directorio de forma segura.
  final dir = await getApplicationDocumentsDirectory();

  //! 📌 Verificación de instancias abiertas de Isar
  //? `Isar.instanceNames.isEmpty` verifica si no hay instancias activas de la base de datos.
  //? Esto evita que se intente abrir una nueva instancia si ya hay una abierta.
  if (Isar.instanceNames.isEmpty) {
   //! 📌 Si no hay ninguna instancia abierta, se abre una nueva con el esquema `MovieSchema`.
   //? - `inspector: true`: Habilita el inspector de Isar para depuración.
   //? - `directory: dir.path`: Especifica la ubicación donde se guardará la base de datos.
   return await Isar.open([
    MovieSchema,
    FavoriteMovieSchema,
    WatchedMovieSchema,
    WatchlistMovieSchema
   ], inspector: true, directory: dir.path);
  }

  //! 📌 Si ya hay una instancia abierta, simplemente la retorna en lugar de abrir una nueva.
  return Future.value(Isar.getInstance());
 }

 //! `isMovieFavorite(movieId)`: Verifica si una película está marcada como favorita.
 //? 📌 `movieId`: ID de la película que se quiere comprobar.
 //? 📌 Devuelve un `Future<bool>` que indica si la película está guardada en la base de datos (`true`) o no (`false`).
 //? 📌 Utiliza la consulta `filter().idEqualTo(movieId).findFirst()` para buscar una película con el ID proporcionado.
 @override
 Future<bool> isMovieFavorite(int movieId) async {
  //! 📌 Obtiene la instancia de la base de datos.
  final isar = await db;

  //! 📌 Busca la película en la base de datos filtrando por `id`.
  final FavoriteMovie? isMovieFavorite =
    await isar.favoriteMovies.filter().movieIdEqualTo(movieId).findFirst();

  //! 📌 Si `isMovieFavorite` no es `null`, significa que la película está almacenada en favoritos.
  return isMovieFavorite != null;
 }

 //! `toggleFavorite(movie)`: Agrega o elimina una película de la lista de favoritos.
 //? 📌 `movie`: Objeto de tipo `Movie` que representa la película que se quiere marcar o desmarcar como favorita.
 //? 📌 Si la película ya está guardada en la base de datos, se elimina (se desmarca como favorita).
 //? 📌 Si la película no está en la base de datos, se guarda (se marca como favorita).
 @override
 Future<void> toggleFavorite(Movie movie) async {
  final isar = await db;

  //! 📌 Verifica si la película ya está en la base de datos (es decir, si ya es un favorito).
  final favoriteMovie =
    await isar.favoriteMovies.filter().movieIdEqualTo(movie.id).findFirst();

  //? `writeTxnSync` inicia una transacción de escritura sincronizada en la base de datos.
  await isar.writeTxnSync(() async {
   if (favoriteMovie != null) {
    //! 📌 Si la película ya está marcada como favorita, se elimina de la base de datos.
    //? `isar.movies.deleteSync(favoriteMovie.isarId!)` elimina la película de favoritos usando su `isarId`.
    isar.favoriteMovies.deleteSync(favoriteMovie.isarId);
   } else {
    //! 📌 Si la película no estaba en favoritos, se guarda en la base de datos.
    //? `isar.movies.putSync(movie)` guarda la película.
    isar.favoriteMovies.putSync(FavoriteMovie(movieId: movie.id));
   }
  });
 }

 //! `loadMovies({String schemaName = 'favorites' , int limit = 10, offset = 0})`:
 //! Obtiene una lista de películas desde un esquema específico de la base de datos local (`favoriteMovies`, `watchedMovies`, `watchlistMovies`).
 //? 📌 `schemaName`: Nombre del esquema desde el cual se cargarán las películas. Puede ser `'favorites'`, `'watched'` o `'watchlist'`.
 //? 📌 `limit`: Número máximo de películas a devolver (por defecto 10).
 //? 📌 `offset`: Número de películas a omitir en la consulta (por defecto 0).
 //? 📌 Devuelve un `Future<List<Movie>>` con las películas encontradas en la base de datos.
 @override
 Future<List<Movie>> loadMovies(
  {String schemaName = 'favorites' , int limit = 10, offset = 0}) async {
  final isar = await db;

  //! 📌 `movieIds` almacenará los IDs de las películas encontradas en el esquema especificado.
  List<int> movieIds = [];

  //! 📌 Se selecciona el esquema de Isar según el valor de `schemaName`.
  switch (schemaName) {
   case 'favorites': // Cargar películas favoritas
    movieIds = await isar.favoriteMovies
      .where()
      .findAll()
      .then((movies) => movies.map((fav) => fav.movieId).toList());
    break;
   case 'watched': // Cargar películas vistas
    movieIds = await isar.watchedMovies.where().findAll().then(
      (movies) => movies.map((watched) => watched.movieId).toList());
    break;
   case 'watchlist': // Cargar películas en la lista de seguimiento
    movieIds = await isar.watchlistMovies.where().findAll().then(
      (movies) => movies.map((watchlist) => watchlist.movieId).toList());
    break;
   default:
    //! 📌 Si el esquema no coincide con ninguna opción válida, se retorna una lista vacía.
    return [];
  }

  //! 📌 Se buscan y devuelven las películas almacenadas en el esquema filtrado.
  //! `anyOf(movieIds, (q, id) => q.idEqualTo(id))` filtra por los IDs obtenidos del esquema seleccionado.
  return isar.movies
    .filter()
    .anyOf(movieIds, (q, id) => q.idEqualTo(id))
    .offset(offset)
    .limit(limit)
    .findAll();
 }

}
