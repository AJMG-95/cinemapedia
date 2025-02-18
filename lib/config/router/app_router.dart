import 'package:cinemapedia/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia/presentation/views/home_views/home_view.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

///! Configuración del enrutador principal de la aplicación.
///* Se utiliza `GoRouter` para manejar la navegación dentro de la app.
///? La navegación se estructura en rutas principales y rutas hijas.
///? - `initialLocation`: Define la pantalla inicial de la aplicación.
///? - `routes`: Lista de rutas disponibles en la app.
final appRouter = GoRouter(
  initialLocation: '/', // Ruta inicial de la aplicación
  routes: [
    ShellRoute(
      // builder: algo que se llama en tiempo de ejecución para construir algo.
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
             GoRoute(
              path: 'movie/:id', // No se usa `/` al inicio porque es una subruta de `/`
              name: MovieScreen.name,
              builder: (context, state) {
                //? Obtiene el `id` de la película desde los parámetros de la URL.
                //? Si no se encuentra, asigna 'no-id' por defecto.
                final movieId = state.pathParameters['id'] ?? 'no-id';

                //Retorna la pantalla de detalles de la película con el `movieId` recibido.
                return MovieScreen(movieId: movieId);
              },
            ),
          ]
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          }
        ),
      ],
    ),

    /*
      ! Configuración de rutas padre/hijo

      * Ruta principal (HomeScreen)
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),

        * Definición de rutas hijas dentro de HomeScreen.
        * Permite regresar a '/' desde la AppBar del widget hijo, incluso si se accedió por un deeplink.
        routes: [
          GoRoute(
            path:
                'movie/:id', // No se usa `/` al inicio porque es una subruta de `/`
            name: MovieScreen.name,
            builder: (context, state) {
              ? Obtiene el `id` de la película desde los parámetros de la URL.
              ? Si no se encuentra, asigna 'no-id' por defecto.
              final movieId = state.pathParameters['id'] ?? 'no-id';

              Retorna la pantalla de detalles de la película con el `movieId` recibido.
              return MovieScreen(movieId: movieId);
            },
          ),
        ],
      ),
    */
  ],
);
