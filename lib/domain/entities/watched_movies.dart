import 'package:isar/isar.dart';

part 'watched_movie.g.dart';

@Collection()
class WatchedMovie {
 Id isarId = Isar.autoIncrement;

 @Index()
 late int movieId;

 late DateTime watchedDate;

 WatchedMovie({required this.movieId, required this.watchedDate});
}
