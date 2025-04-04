//Esta pantalla es para mostrar la vista detalle de una pelicula

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  // Es mejor recibir el id que la pelicula para poder implementar
  //  el deepLinking
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() =>
      MovieScreenState(); // crea una instancia del ConsumerState
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    /*
    read se usa cuando no queremos que el widget se reconstruya si el estado cambia.
    Se usa en initState porque esta función solo se ejecuta una vez cuando el widget se monta, por lo que no necesita reconstruirse cada vez que cambia el estado del provider.
    read obtiene el valor actual del provider, pero no escucha los cambios.
  */
    //* ref.read(provider.notifier)
    //*   -> Obtiene el notifier del provider sin escuchar cambios.
    //*   -> Se usa cuando necesitas ejecutar una acción en el provider (ejemplo: loadMovie()).
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Cargando'),
          ),
          body: const Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        // se usa un CustomScrollView para trabajar con slivers
        physics:
            const ClampingScrollPhysics(), // elimina el efecto rebote de ios
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(
                        movie: movie,
                      ),
                  childCount:
                      1 // Se especifica que solo va a tener un elemento para evitar duplicidades
                  ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) return const SizedBox();
                    return FadeIn(child: child);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                    ),
                    const SizedBox(
                        height:
                            8), // Espaciado entre el título y la descripción
                    RichReadMoreText.fromString(
                      text: movie.overview, // Descripción de la película
                      settings: LengthModeSettings(
                        trimLength:
                            150, // Cantidad de caracteres antes de mostrar "Expand"
                        trimCollapsedText: 'Leer más',
                        trimExpandedText: ' Leer menos ',
                        lessStyle: TextStyle(
                            color: colors.primary, fontWeight: FontWeight.bold),
                        moreStyle: TextStyle(
                            color: colors.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                ...movie.genreIds.map((gender) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Chip(
                        label: Text(
                          gender,
                          style: textStyle.labelSmall,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ))
              ],
            )),
        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    // No se llama al reed sino al watch sobre provider NO al notifier,
    //  actorsByMovie guarda directamente la lista de actores
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: FadeInRight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        width: 135,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return const SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            );
                          }
                          return FadeIn(child: child);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      actor.name,
                      maxLines: 2,
                    ),
                    Text(actor.character ?? "",
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis))
                  ],
                ),
              ),
            );
          }),
    );
  }
}

///! `isFavoriteProvider` OJO este provider está aquí porque es pequeño y solo se usa aquí
///* Este `FutureProvider.family.autoDispose` se encarga de verificar si una película está marcada como favorita.
/*
?`family`:
  - `family` permite que el provider acepte un parámetro dinámico (en este caso, `movieId`).
  - Cada valor único de `movieId` genera una instancia distinta del provider.
  - Útil cuando queremos manejar múltiples valores simultáneamente sin que se sobrescriban entre sí.
*/
/*
?`autoDispose`:
  - `autoDispose` asegura que cuando el provider ya no se use, se elimine automáticamente.
  - Ayuda a liberar memoria y evitar fugas de estado innecesarias.
  - Se destruye cuando no hay más widgets observando el provider, evitando mantener datos en memoria más tiempo del necesario.
*/
///* - `ref.watch(localStorageRepositoryPrivder)`: Obtiene el repositorio local de almacenamiento.
///* - `isMovieFavorite(movieId)`: Retorna un `Future<bool>` indicando si la película es favorita o no.
final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryPrivder);
  return localStorageRepository.isMovieFavorite(movieId);
});


class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        //! `IconButton` para marcar o desmarcar una película como favorita.
        //? - `ref.watch(localStorageRepositoryPrivder).toggleFavorite(movie)`: Alterna el estado de favorito.
        //? - `ref.invalidate(isFavoriteProvider(movie.id))`: Invalida el estado para forzar una actualización visual.
        IconButton(
            onPressed: () async {
              /* await ref.read(localStorageRepositoryPrivder).toggleFavorite(movie); */

              await ref.read(favoriteMoviesProvider.notifier).toggleFavorite (movie);

              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
              loading: () => const CircularProgressIndicator(
                strokeWidth: 2,
              ),
              data: (isFavorite) => isFavorite
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border),
              /*
                ? Manejo de errores con `UnimplementedError()`:
                - Este error se lanza si ocurre un fallo en el provider al obtener el estado de favorito.
                - En un escenario real, se debería manejar el error de una forma más adecuada, como mostrando un mensaje en pantalla.
              */
              error: (_, __) => throw UnimplementedError(),
            ))
      ],
      flexibleSpace: FlexibleSpaceBar(
        /* titlePadding: const EdgeInsets.only(left: 10, bottom: 7),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.start,
        ), */
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.0,
                  0.2
                ],
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ]),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.8,
                  1.0
                ],
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ]),
            const _CustomGradient(begin: Alignment.topLeft, stops: [
              0.0,
              0.3
            ], colors: [
              Colors.black87,
              Colors.transparent,
            ]),
          ],
        ),
      ), // Espacioflexible del customAppBar
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
