import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';

///! `HomeView`: Vista principal dentro de `HomeScreen`.
///? Se encarga de gestionar la carga inicial de las películas.
///? Extiende `ConsumerStatefulWidget` para poder acceder a `ref` y manejar estado.
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  /*
    Al modifi la clase del estado a ConsumerState<HomeView>, este override
    se modifica combiertiendose en una instacia de la propias clase HomeViewState.
    State<HomeView> createState() => HomeViewState() -> HomeViewState createState() => HomeViewState();
  */
  @override
  HomeViewState createState() => HomeViewState();
}

///! `HomeViewState`: Estado de `HomeView`
///? Se encarga de inicializar la carga de datos al iniciar la vista.
///? Usa `ConsumerState` para acceder a `ref` y gestionar la carga de datos.
/*
  Al tratatarse de un ConsumerStatefulWidget el state cambia:
    State<HomeView> -> ConsumerState<HomeView>, lo que implica un cambio en el
    overre del state de la clase
 */
class HomeViewState extends ConsumerState<HomeView> {
  ///! `initState`: Método que se ejecuta una sola vez cuando se monta el widget.
  ///? Se usa para cargar las películas de las distintas categorías.
  @override
  void initState() {
    super.initState();

    /*
      Dentro del initState se quiere llamar de alguna manera al notifier y desde ahí
      al método loadNextPage, para ello hay que llamar el ref, y para tener acceso al
      ref es necesario que el widget sea un ConsumerWidget.
      En este caso al ser un statefullwidget se usa la clase ConsumerStatefulWidget,
      lo que implica la modificación del state a un ConsumerState
    */
    //! Carga inicial de las películas en distintas categorías.
    //! Se usa `.read()` porque solo se necesita ejecutar la acción sin suscribirse al estado.
    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); // Llama al método loadNextPage, haciendo la petición pero sin renderizar los datos. No regrasa el valor del estado sino el notifier
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();

    //! `read()` ejecuta la acción, mientras que `watch()` se usa para observar cambios en el estado.
    /*
      Básicamente el read() llama a la siguiente página y cuando se obtinene los datos
      de peliculas, estos se muestran mediante el watch.
    */
  }

  ///! `build`: Método que renderiza la interfaz gráfica del `HomeView`.
  ///? Se encarga de mostrar la lista de películas organizadas por categorías.
  /*
    Ahora al se un ConsumerState, a lo largo de la clase se tiene acceso al ref de
    manera global en todo el scope de la clase, por lo que no es necesario pasar
    el ref como argumento del constructor.
  */
  @override
  Widget build(BuildContext context) {
    //* 🔄 Muestra una pantalla de carga si los datos aún no han sido obtenidos.
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    //! 📌 Obtener el estado de cada provider de películas
    /*
      En riverpod al usar ref.watch automaticamente se obtine el valor del estado del provider.
      Se usa watch porque se necesita estar pendiente de los cambios en el estado del provider.
    */
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); // En cines
    final slideShowMovies = ref.watch(moviesSlideshowProvider); // Carrusel
    final popularMovies = ref.watch(popularMoviesProvider); // Populares
    final upComingMovies = ref.watch(upComingMoviesProvider); // Próximamente
    final topRatedMovies = ref.watch(topRatedMoviesProvider); // Mejor valoradas

    //* 🔹 `CustomScrollView`: Permite aplicar `Slivers` para un scroll avanzado
    /*
      Los Slivers son son widgets de un SliverAppBar, este tipo de appnar permite
      introducir comportamientos de scroll en la appbar, como en este caso que se
      muestra/oculta el appbar
    */
    return CustomScrollView(
      slivers: [
        //! `SliverAppBar`: Barra superior con efecto flotante
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),

        //! `SliverList`: Contenido de la pantalla con las listas de películas
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  //* 🔹 Carrusel de películas destacadas
                  MoviesSlideshow(movies: slideShowMovies),

                  //* 🔹 Lista horizontal de películas en cines
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle:
                        'Hoy: ${DateTime.now().day}/${DateTime.now().month}',
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                  //* 🔹 Lista horizontal de películas populares
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),

                  //* 🔹 Lista horizontal de películas próximas a estrenarse
                  MovieHorizontalListview(
                    movies: upComingMovies,
                    title: 'Próximamente',
                    loadNextPage: () => ref
                        .read(upComingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                  //* 🔹 Lista horizontal de películas mejor valoradas
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor Valoradas',
                    loadNextPage: () => ref
                        .read(topRatedMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                  const SizedBox(height: 15), // Espaciado final
                ],
              );
            },
            childCount: 1, // Solo una vez, ya que es una lista única
          ),
        ),
      ],
    );
  }
}
