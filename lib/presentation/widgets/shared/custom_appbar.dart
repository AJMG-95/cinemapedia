import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                'Cinemapedia',
                style: titleStyle,
              ),
              // El Spacer es como un flex que lo que hace es ocupar todo
              //  el espacio disponible en el padre.
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
