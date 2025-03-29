import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class BeatingHeartIcon extends StatefulWidget {
  final double size;
  final Color color;

  const BeatingHeartIcon({super.key, this.size = 60, required this.color});

  @override
  State<BeatingHeartIcon> createState() => _BeatingHeartIconState();
}

class _BeatingHeartIconState extends State<BeatingHeartIcon> {
  bool animate = true;

  @override
  void initState() {
    super.initState();
    _startHeartbeat();
  }

  Future<void> _startHeartbeat() async {
    while (mounted) {
      setState(() => animate = true);
      await Future.delayed(const Duration(milliseconds: 350)); // bump
      setState(() => animate = false);
      await Future.delayed(const Duration(milliseconds: 200)); // short pause
      setState(() => animate = true);
      await Future.delayed(const Duration(milliseconds: 350)); // second bump
      setState(() => animate = false);
      await Future.delayed(const Duration(milliseconds: 1000)); // full pause
    }
  }

  @override
  Widget build(BuildContext context) {
    return animate
        ? Pulse(
            duration: const Duration(milliseconds: 300),
            child: Icon(Icons.favorite, size: widget.size, color: widget.color),
          )
        : Icon(Icons.favorite, size: widget.size, color: widget.color);
  }
}
