import 'package:isar/isar.dart';

///! `part 'movie.g.dart';` se utiliza para indicar que este archivo está vinculado a otro archivo generado.
///* Isar genera automáticamente un archivo `movie.g.dart` que contiene el código necesario para serializar y deserializar los objetos de la clase `Movie`.
///? Este archivo generado maneja la configuración de la base de datos y permite que Isar realice consultas eficientes sobre la colección `Movie`.
///* Es necesario ejecutar el comando `flutter pub run build_runner build` 0 'dart run build_runner build' para generar o actualizar `movie.g.dart` cuando se realizan cambios en la clase.
part 'movie.g.dart';

///! Definición de una colección de Isar para almacenar películas en la base de datos local,
///!  para ello se usa la entidad de las peliculas (Movie) .
///* Isar es una base de datos NoSQL optimizada para Flutter/Dart, diseñada para ser rápida y eficiente.
///? Al marcar la clase con `@collection`, se indica que esta es una colección de Isar y será almacenada en la base de datos local.
@collection
class Movie {
  //? En Isar, cada objeto almacenado debe tener un identificador único.
  //? `Id?` es un tipo especial en Isar que permite generar automáticamente un identificador único si no se proporciona.
  Id? isarId;   //! `isarId`: Identificador único para Isar.

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

  //! Constructor de la clase `Movie`.
  //? Requiere que todos los campos sean proporcionados al crear una instancia.
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
