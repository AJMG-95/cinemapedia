//* `initialLoadingProvider`: Proveedor de solo lectura (`Provider<bool>`)
//? que indica si la aplicación sigue cargando datos iniciales.
//? Comprueba si alguna de las listas de películas aún está vacía.

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///! `initialLoadingProvider`: Determina si la aplicación sigue en estado de carga inicial.
///? Este provider evalúa si alguna de las listas de películas (`nowPlaying`, `popular`,
///? `upComing`, `topRated`) aún está vacía. Si alguna lo está, devuelve `true`, indicando
///? que la aplicación todavía está cargando datos. Si todas las listas tienen contenido,
///? devuelve `false`, indicando que la carga inicial ha finalizado.

final initialLoadingProvider = Provider<bool>((ref) {
  // 🔄 Verifica si la lista de películas en cartelera está vacía.
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;

  // 🔄 Verifica si la lista de películas populares está vacía.
  final step2 = ref.watch(popularMoviesProvider).isEmpty;

  // 🔄 Verifica si la lista de próximas películas está vacía.
  final step3 = ref.watch(upComingMoviesProvider).isEmpty;

  // 🔄 Verifica si la lista de películas mejor valoradas está vacía.
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  // ✅ Si alguna de las listas está vacía, significa que la aplicación sigue cargando.
  if (step1 || step2 || step3 || step4) return true;

  // ✅ Si todas las listas tienen contenido, la carga inicial ha finalizado.
  return false;
});
