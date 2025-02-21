import 'package:isar/isar.dart';

part 'favorite_movie.g.dart';

@Collection()
class FavoriteMovie {
  Id isarId = Isar.autoIncrement;

  @Index()
  late int movieId; // Se referencia el `id` de Movie

  FavoriteMovie({required this.movieId});
}
