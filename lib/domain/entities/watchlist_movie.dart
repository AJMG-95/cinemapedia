import 'package:isar/isar.dart';

part 'watchlist_movie.g.dart';

@Collection()
class WatchlistMovie {
  Id isarId = Isar.autoIncrement;

  @Index()
  late int movieId;

  WatchlistMovie({required this.movieId});
}
