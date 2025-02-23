import 'package:cinemapedia/presentation/providers/storage/favorite_movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///! `FavoritesView`
///* Este widget es un `ConsumerStatefulWidget`, lo que permite consumir providers de forma dinámica.
/*
? `ConsumerStatefulWidget`:
  - Se usa en lugar de `StatefulWidget` cuando un widget necesita acceder a `ref`.
  - Permite escuchar y modificar el estado de los providers de manera eficiente.
  - Ideal cuando el widget debe reconstruirse dinámicamente al cambiar el estado del provider.
*/
class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

///! `FavoritesViewState`
///* Al ser `ConsumerStatefulWidget`, su `State` es de tipo `ConsumerState` en lugar de `State`.
/*
? `ConsumerState<FavoritesView>`:
  - `ConsumerState` proporciona acceso directo al `ref`.
  - `ref` permite leer, ver y escuchar cambios en los providers sin necesidad de `Consumer`.
  - Es útil cuando se necesita acceder a un provider en `initState()`.
*/
class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    //! Carga la primera página de películas favoritas al iniciar la vista.
    ref.read(favoriteMoviesProvider.notifier).loadNexPage();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref
        .watch(favoriteMoviesProvider)
        .values
        .toList(); //! Observa la lista de películas favoritas.

    return Scaffold(
      body: MovieMasonry(movies: favoriteMovies)
    );
  }
}
