import 'package:flutter/material.dart';

class StackedImages3D extends StatefulWidget {
  final List<String> images;

  const StackedImages3D({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<StackedImages3D> createState() => _StackedImages3DState();
}

class _StackedImages3DState extends State<StackedImages3D> {
  double _rotationX = -0.3;
  double _rotationY = 0.3;
  double _lastDx = 0;
  double _lastDy = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _lastDx = details.localPosition.dx;
        _lastDy = details.localPosition.dy;
      },
      onPanUpdate: (details) {
        final dx = details.localPosition.dx - _lastDx;
        final dy = details.localPosition.dy - _lastDy;

        setState(() {
          _rotationY += dx * 0.002;
          _rotationX -= dy * 0.002;
        });

        _lastDx = details.localPosition.dx;
        _lastDy = details.localPosition.dy;
      },
      child: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_rotationX)
            ..rotateY(_rotationY),
          alignment: Alignment.center,
          child: SizedBox(
            width: 320,
            height: 420,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildStackedImage(
                  imagePath: widget.images[2],
                  index: 2,
                  translateY: 40,
                  scale: 0.88,
                ),
                _buildStackedImage(
                  imagePath: widget.images[1],
                  index: 1,
                  translateY: 20,
                  scale: 0.94,
                ),
                _buildStackedImage(
                  imagePath: widget.images[0],
                  index: 0,
                  translateY: 0,
                  scale: 1.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStackedImage({
    required String imagePath,
    required int index,
    required double translateY,
    required double scale,
  }) {
    return Transform.translate(
      offset: Offset(0, translateY),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 340,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 30,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder(index);
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(int index) {
    final List<List<Color>> gradients = [
      [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)],
      [const Color(0xFF991B1B), const Color(0xFFEF4444)],
      [const Color(0xFF1E40AF), const Color(0xFF8B5CF6)],
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradients[index % gradients.length],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.movie,
          size: 60,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
