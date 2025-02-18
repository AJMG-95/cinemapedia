import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

///! Configuración del enrutador principal de la aplicación.
///* Se utiliza `GoRouter` para manejar la navegación dentro de la app.
///? La navegación se estructura en rutas principales y rutas hijas.
///? - `initialLocation`: Define la pantalla inicial de la aplicación.
///? - `routes`: Lista de rutas disponibles en la app.
final appRouter = GoRouter(
  initialLocation: '/home/0', // Ruta inicial de la aplicación
  routes: [
    //* Ruta principal (HomeScreen)
    GoRoute(
      //Se le pone un nombre a la ruta y se le pasa un parámetro "page" que sirve para indicar el view que se quiere mostrar (tabs de la navbar)
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        var pageIndex =
            int.tryParse(state.pathParameters['page'] ?? '0') ?? 0;

        pageIndex = pageIndex < 0 || pageIndex > 2 ? 0 : pageIndex;

        return HomeScreen(
          pageIndex: pageIndex,
        );
      },
      //* Definición de rutas hijas dentro de HomeScreen.
      //* Permite regresar a '/' desde la AppBar del widget hijo, incluso si se accedió por un deeplink.
      routes: [
        GoRoute(
          path:
              'movie/:id', // No se usa `/` al inicio porque es una subruta de `/`
          name: MovieScreen.name,
          builder: (context, state) {
            //? Obtiene el `id` de la película desde los parámetros de la URL.
            //? Si no se encuentra, asigna 'no-id' por defecto.
            final movieId = state.pathParameters['id'] ?? 'no-id';

            // Retorna la pantalla de detalles de la película con el `movieId` recibido.
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),

    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ],
);
