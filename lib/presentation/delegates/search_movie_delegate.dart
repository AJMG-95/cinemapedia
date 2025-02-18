import 'dart:async';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

//* Definición de un tipo de función para la búsqueda de películas.
//? Este `typedef` define un callback que recibe un `String` (el query de búsqueda)
//? y devuelve un `Future<List<Movie>>`, lo que permite implementar diferentes estrategias
//? de búsqueda en distintas partes de la aplicación.
typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

//! Clase que extiende `SearchDelegate` para la búsqueda de películas en la aplicación.
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  /*
    Para que realmente este SearchMovieDelegate funcione para buscar películas
    hay que definir una función para buscar películas. Para ello,
    hay que definir un tipo de función específica con typedef.
    Cualquier implementación que cumpla con:
    1º Recibir un String.
    2º Devolver un Future<List<Movie>>.
    será válida.
  */
  //? Callback que se ejecutará para realizar la búsqueda de películas.
  final SearchMovieCallback searchMovies;

  /*
    Debe ser un broadcast porque cada vez que el usuario escribe y se redibuja
    la lista de películas, esta se vuelve a suscribir al controlador.
    OJO: Si se sabe que solo hay un widget escuchando, se puede dejar como un StreamController normal.
    Pero si no se sabe, es mejor dejarlo como broadcast para que pueda tener múltiples listeners.
  */
  //* StreamController que gestionará la emisión de las películas encontradas en la búsqueda.
  //? Se usa un `broadcast` para permitir múltiples listeners simultáneamente.
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();

  //*StreamController que gestionará el icono/función del buildActions
  final StreamController<bool> _isLoadingStream = StreamController<bool>.broadcast();

  //* Temporizador (`Timer`) para manejar la espera antes de realizar la búsqueda.
  //? Sirve para evitar múltiples peticiones seguidas mientras el usuario escribe.
  Timer? _debounceTimer;
  List<Movie>? initialMovies;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }) : super(
          searchFieldLabel: 'Buscar películas',
          /* textInputAction: TextInputAction.done, */ // Esto cambia el tecto del botón de busqueda en el teclado del movil.
        );

  //* Este método se ejcuta cuando se deja de usar el delegate (SearchMovieDelegate)
  //? Este método cierra por completo el stream debounceMovies
  void clearStreams() {
    debounceMovies.close();
  }

  //* Método que se ejecuta cuando el usuario cambia el texto en la barra de búsqueda.
  //? Implementa un "debounce" para evitar hacer peticiones en cada pulsación de tecla.
  void _onQueryChange(String query) {

    _isLoadingStream.add(true);

    // Si hay un temporizador en ejecución, se cancela para reiniciar la espera.
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    // Se establece un nuevo temporizador con 500ms de espera antes de hacer la búsqueda.
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        // Se realiza la búsqueda y se emiten los resultados.
        final movies = await searchMovies(query);
        initialMovies = movies;
        debounceMovies.add(movies);
        _isLoadingStream.add(false);
      },
    );
  }

  //* Configura el texto de placeholder en la barra de búsqueda.
  /*
  @override
  String? get searchFieldLabel => 'Buscar película';
  */

  //! Este método evita la duplicación de código entre buildResults y buildSuggestions
  Widget _buildResultsAndSuggestions() {
    // Si el usuario no ha escrito nada, muestra un mensaje informativo.
    if (query.isEmpty) {
      return const Center(
          child: Text("Empieza a escribir para buscar películas"));
    }

    return StreamBuilder(
        initialData: initialMovies,
        stream: debounceMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          // Si no hay películas y el query no está vacío, se muestra un mensaje.
          if (movies.isEmpty && query.isNotEmpty) {
            return const Center(
                child: Text("No hay películas que coincidan con su búsqueda"));
          }

          // Construcción de la lista de resultados de la búsqueda.
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => _MovieItem(
                    movie: movies[index],
                    /*
                    Se deben pasar `context` y `movie` por las siguientes razones:
                    📌 `context`:
                      - `context` es necesario porque `close(context, movie)` se encarga de cerrar la búsqueda y retornar la película seleccionada.
                      - Al ser un `SearchDelegate`, su cierre debe realizarse en el `context` actual para que la pantalla previa reciba el resultado.
                      - Sin `context`, `close()` no sabría desde qué punto en la jerarquía de widgets debe cerrarse la búsqueda.
                    📌 `movie`:
                      - `movie` representa la película seleccionada y se pasa como parámetro para devolverla como resultado de la búsqueda.
                      - El `SearchDelegate` en Flutter permite devolver un valor cuando se cierra (en este caso, una instancia de `Movie`).
                      - Esto permite que la vista anterior (que invocó la búsqueda) obtenga la película y pueda utilizarla, por ejemplo, para navegar a una pantalla de detalles.
                    🔹 En resumen, `context` permite cerrar el `SearchDelegate` correctamente y `movie` es el valor que se pasa como resultado al cerrar la búsqueda.
                  */
                    onMovieSelected: (context, movie) {
                      clearStreams();
                      close(context, movie);
                    },
                  ));
        });
  }

  //* Construye las acciones de la barra de búsqueda (ej. botón de limpiar texto).
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: _isLoadingStream.stream,
        builder: (context, snapshot) {
          // Cuando esto es true sigminifica que está cargando
          if (snapshot.data ?? false) {
            if (snapshot.data == true && query.isNotEmpty) {
              return SpinPerfect(
                duration: const Duration(seconds: 10),
                spins: 10,
                infinite: true,
                child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.refresh_rounded)),
              );
            }
          }
          return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(microseconds: 200),
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      )
    ];
  }

  //* Construye el icono a la izquierda de la barra de búsqueda (botón de retroceso).
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  //* Construye los resultados de la búsqueda cuando el usuario presiona "Enter".
  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions();
  }

  //* Construye las sugerencias de búsqueda mientras el usuario escribe.
  @override
  Widget buildSuggestions(BuildContext context) {
    // Se llama a `_onQueryChange` cada vez que se actualiza la consulta.
    _onQueryChange(query);
    // Se usa un `StreamBuilder` para actualizar la lista de sugerencias en tiempo real.
    return _buildResultsAndSuggestions();
  }
}

//! Widget privado que representa un elemento individual en la lista de resultados de búsqueda.
class _MovieItem extends StatelessWidget {
  final Movie movie;

  //* Callback que se ejecuta cuando se selecciona una película de la lista.
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      // Cuando se selecciona una película, se cierra la búsqueda y se devuelve el resultado.
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Imagen del póster de la película.
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
            const SizedBox(width: 10),

            //* Información textual de la película (título, descripción, calificación).
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* Título de la película (limitado a 60 caracteres para evitar desbordes).
                  (movie.title.length > 60)
                      ? Text(
                          '${movie.title.substring(0, 60)}...',
                          style: textStyles.titleLarge,
                        )
                      : Text(
                          movie.title,
                          style: textStyles.titleLarge,
                        ),

                  //* Descripción de la película (limitada a 150 caracteres).
                  (movie.overview.length > 150)
                      ? Text('${movie.overview.substring(0, 150)}...')
                      : Text(movie.overview),

                  //* Calificación de la película con estrellas.
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
