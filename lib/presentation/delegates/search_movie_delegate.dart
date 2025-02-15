import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';


typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  //* Para que realmente este SearchMovieDelegate funcione para buscar peliculas
  //* hay que definir una función para buscar películas, `para ello
  //* hay que definir un tipo de función especifica con typedef
  //* valdría Cualquier implementacion que cunpla con:
  //* 1º Recibir un String y 2º Devolver una List<Movie>

  final SearchMovieCallback searchMovies;

  SearchMovieDelegate({
    required this.searchMovies,
  });

  // Esto es para el placeholder de la barra de búsqueda
  @override
  String? get searchFieldLabel => 'Buscar película';

  // Este método es para construir las acciones de la barra de búsqueda
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(microseconds: 200),
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      )
    ];
  }

  // Contruir un icono (la parte izquierda de la barra de búsqueda)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  // Los resultados que van a aparecer cuando se pulse enter
  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  // Lo que aparece cuanco la persona está escribiendo
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
          child: Text("Empieza a escribir para buscar películas"));
    }
    return FutureBuilder(
        future: searchMovies(query),
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          if (movies.isEmpty && query.isNotEmpty) {
            return const Center(
                child: Text("No hay películas que coincidan con su búsqueda"));
          }
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => _MovieItem(
                    movie: movies[index],
                    onMovieSelected: close,
                  ));
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return FadeIn(child: child);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (movie.title.length > 60)
                  ? Text(
                      '${movie.title.substring(0, 60)}...',
                      style: textStyles.titleLarge,
                    )
                  : Text(
                      movie.title,
                      style: textStyles.titleLarge,
                    ),
              (movie.overview.length > 150)
                  ? Text('${movie.overview.substring(0, 150)}...')
                  : Text(movie.overview),
              Row(
                children: [
                  Icon(
                    Icons.star_half_rounded,
                    color: Colors.yellow.shade800,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(HumanFormats.number(movie.voteAverage, 1),
                      style: textStyles.bodyMedium!.copyWith(
                        color: Colors.yellow.shade900,
                      ))
                ],
              )
            ],
          ))
        ]),
      ),
    );
  }
}
