import 'package:cinemapedia/presentation/widgets/widgets_barrel.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-creen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomBottonNavigation(),
    );
  }
}

// Cuando el HomeView se carga se quiere mandar a llamar en ciclo de vida la carga
//  de la primera página
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  // Al modifi la clase del estado a ConsumerState<_HomeView>, este override
  //  se modifica combiertiendose en una instacia de la propias clase _HomeViewState
  // State<_HomeView> createState() => _HomeViewState() -> _HomeViewState createState() => _HomeViewState();
  @override
  _HomeViewState createState() => _HomeViewState();
}

// Al tratatarse de un ConsumerStatefulWidget el state cambia:
// State<_HomeView> -> ConsumerState<_HomeView>, lo que implica un cambio en el
// overre del state de la clase
class _HomeViewState extends ConsumerState<_HomeView> {
  // Para realizar la carga incial es necesario llamar al método initState
  @override
  void initState() {
    super.initState();
    // Dentro del initState se quiere llamar de alguna manera al notifier y desde ahí
    //  al método loadNextPage, para ello hay que llamar el ref, y para tener acceso al
    //  ref es necesario que el widget sea un ConsumerWidget.
    // En este caso al ser un statefullwidget se usa la clase ConsumerStatefulWidget, lo que implica
    //  la modificación del state a un ConsumerState
    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); // Llama al método loadNextPage, haciendo la petición pero sin renderizar los datos
    //* ^^^ Esto no regrasa el valor del estado sino el notifier

    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();

    //! Básicamente el read llama a la siguiente página y cuando se obtinene los datos se muestran
    //!   los datos de las peliculas mediante el watch.
  }

  //* Ahora al se un ConsumerState, a lo largo de la clase se tiene acceso al ref de
  //*   manera global, en todo el scope de la clase, por lo que no es necesario pasar
  //*   el ref como argumento del constructor
  @override
  Widget build(BuildContext context /*, ref */) {
    //Esto es para introducir una pantalla de carga incicial antes de renderizar nada
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    // En riverpod al hacer ref.watch automaticamente se obtine el valor del estado del provider
    //  En este caso el estado es una lista de peliculas List<Movie>
    // En este caso se usa watch porque se necesita estar pendiente del estado del provider
    final nowPLayingMovies = ref.watch(nowPlayingMoviesProvider);
    //* ^^^ Esto regresa el valor del estado (y es que, en este punto, solo se necesita accecer al valor del estado del provider)
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    //* CustomScrollView es para poder aplicar los slivers, son widgets (SliverAppBar) que
    // * que me permiten introcucir comportamientos con el scroll, como en este caso
    // * la aparicion/desaparición del appbar
    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: CustomAppbar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            /* const CustomAppbar(), */
            MoviesSlideshow(
              movies: slideShowMovies,
            ),
            MovieHorizontalListview(
              movies: nowPLayingMovies,
              title: 'En cines',
              subTitle: 'Hoy: ${DateTime.now().day}/${DateTime.now().month}',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              loadNextPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: upComingMovies,
              title: 'Próximamente',
              loadNextPage: () =>
                  ref.read(upComingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor Valoradas',
              loadNextPage: () =>
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
