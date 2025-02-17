import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                'Cinemapedia',
                style: titleStyle,
              ),
              // El Spacer es como un flex que lo que hace es ocupar todo
              //  el espacio disponible en el padre.
              const Spacer(),

              IconButton(
                  onPressed: () {
                    //Estas son las peliculas previamente buscadas
                    final searchedMovies = ref.read(searchedMoviesProvider);
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(
                      //! Se puede pasar un valor inicial al `showSearch`.
                      //? Esto permite reutilizar la búsqueda sin que el usuario tenga que volver a escribir manualmente el término.
                      //? `searchQuery` almacena el último término buscado, lo que permite que la consulta persista incluso si el `SearchDelegate` se destruye.
                      query: searchQuery,

                      //! Se debe proporcionar el contexto actual para que `showSearch` pueda abrir la pantalla de búsqueda.
                      //? `context` es necesario para determinar en qué parte de la jerarquía de widgets se encuentra la ejecución.
                      context: context,

                      //! `delegate` es el encargado de gestionar la búsqueda.
                      //? `SearchMovieDelegate` contiene la lógica para buscar películas en la API y manejar los resultados.
                      //? Este delegate usa `searchMovies`, un callback que realiza la consulta en `movieRepository`.
                      delegate: SearchMovieDelegate(
                        //! `initialMovies`: Películas previamente buscadas.
                        //? Esto evita hacer una nueva petición a la API si ya existen resultados en caché.
                        initialMovies: searchedMovies,
                        //! `searchMovies`: Función que ejecuta la búsqueda.
                        //? `searchMoviesByQuery()` almacena el nuevo término de búsqueda y obtiene los resultados.
                        /*
                          `searchMovies`: Referencia a la función que ejecuta la búsqueda.
                          Se pasa **la referencia al método** (`searchMoviesByQuery`) en lugar de llamarlo (`searchMoviesByQuery(query)`).
                          Esto se debe a que `SearchMovieDelegate` necesita un callback que se ejecutará **más tarde**, cuando el usuario escriba en la barra de búsqueda.
                          Si se llamara `searchMoviesByQuery(query)`, la búsqueda se ejecutaría inmediatamente al construir el `delegate`, lo que **no es deseado**.
                          En cambio, al pasar la referencia `searchMoviesByQuery`, el `SearchDelegate` puede **invocar** la búsqueda en el momento adecuado.
                        */
                        searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery,
                      ),
                    ).then((movie) {
                      //! Se ejecuta cuando la búsqueda finaliza y devuelve un resultado.
                      //? `showSearch` retorna un `Future<Movie?>`, por lo que `.then((movie) {...})`
                      //? se ejecuta al cerrar la búsqueda, ya sea con una película seleccionada o sin resultado.

                      //! Se verifica si el `context` sigue disponible antes de realizar cualquier acción.
                      //? `context.mounted` evita errores si el usuario ha navegado a otra pantalla mientras la búsqueda estaba abierta.
                      if (!context.mounted) return;

                      //! Si el usuario no seleccionó ninguna película, simplemente se sale de la función.
                      if (movie == null) return;

                      //! Si hay una película seleccionada, se navega a la pantalla de detalles de la película.
                      //? `context.push('/movie/${movie.id}')` cambia la ruta a la vista de detalles de la película seleccionada.
                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
