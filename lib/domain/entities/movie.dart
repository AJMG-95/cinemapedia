import 'package:isar/isar.dart';

part 'movie.g.dart';


///! Definición de una colección de Isar para almacenar películas en la base de datos local,
///!  para ello se usa la entidad de las peliculas (Movie) .
///* Isar es una base de datos NoSQL optimizada para Flutter/Dart, diseñada para ser rápida y eficiente.
///? Al marcar la clase con `@collection`, se indica que esta es una colección de Isar y será almacenada en la base de datos local.
@Collection()
class Movie {
  //? En Isar, cada objeto almacenado debe tener un identificador único.
  //? `Id?` es un tipo especial en Isar que permite generar automáticamente un identificador único si no se proporciona.
  Id? isarId = Isar.autoIncrement; // Ahora tiene su propia colección en Isar //! `isarId`: Identificador único para Isar.

  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}
