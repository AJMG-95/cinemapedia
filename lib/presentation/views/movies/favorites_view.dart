import 'package:cinemapedia/presentation/providers/storage/favorite_movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/beating_heart_icon.dart';
import 'package:cinemapedia/presentation/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart'; // Asegúrate de importar animate_do

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          BeatingHeartIcon(color: colors.primary),
            const SizedBox(height: 10),
            Text('Ohhh no!!',
                style: TextStyle(fontSize: 30, color: colors.primary)),
            const Text('No tienes películas favoritas',
                style: TextStyle(fontSize: 20, color: Colors.black45)),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Empieza a buscar'),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favoriteMovies,
      ),
    );
  }
}
