import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final random = Random(movie.id); //  como semilla, para que cada póster tenga su propia animación única, pero estable (no cambia cada vez).
    final delay = Duration(milliseconds: random.nextInt(600)); // entre 0ms y 600ms.

    return FadeInUp(

      delay: delay,
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
