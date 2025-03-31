import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  final double size;
  
  const AnimatedLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _rotationAnimation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _bounceAnimation.value),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_cart,
                  size: widget.size * 0.6,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

