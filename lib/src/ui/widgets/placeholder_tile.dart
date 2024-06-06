import 'package:flutter/material.dart';

class PlaceholderTile extends StatefulWidget {
  const PlaceholderTile({super.key});

  @override
  State<PlaceholderTile> createState() => _PlaceholderTileState();
}

class _PlaceholderTileState extends State<PlaceholderTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int?> _alphaAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _alphaAnimation = IntTween(
      begin: 25,
      end: 75,
    ).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AnimatedBuilder(
        animation: _alphaAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withAlpha(_alphaAnimation.value ?? 25),
                Colors.black.withAlpha(100 - (_alphaAnimation.value ?? 25)),
              ]),
            ),
            height: 18,
          );
        },
      ),
    );
  }
}
