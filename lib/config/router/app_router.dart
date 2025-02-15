import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
    // Lo que hace es que crea una ruta hija de la ruta de /
    //  con lo que se puede volver / desde la appbar del widget de la ruta hija siempre,
    //    aunque se haya entrado desde deeplink
    routes: [
      GoRoute(
        path:
            'movie/:id', // Al ser hijo de / no se necesita la / al principio de la ruta hija
        name: MovieScreen.name,
        builder: (context, state) {
          final movieId = state.pathParameters['id'] ??
              'no-id'; // recoge el id de la movie desde la url de
          return MovieScreen(
              movieId: movieId); // retorna la vista de la pelicula
        },
      ),
    ]
  ),
]);
