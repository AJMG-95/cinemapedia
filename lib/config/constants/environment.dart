import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';
  static String theMovieDbBaseUrl =
      dotenv.env['THE_MOVIEDB_BASE_URL'] ?? 'No hay api base url';
}
