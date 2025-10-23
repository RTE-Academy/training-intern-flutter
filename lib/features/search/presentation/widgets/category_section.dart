import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  Widget _buildCategoryCard(
      String title, String subtitle, String bgPath, String imgPath, bool flip) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: AssetImage(bgPath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: flip ? -25 : null,
            left: flip ? null : -25,
            bottom: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(flip ? 3.1416 : 0),
              child: Image.asset(
                imgPath,
                width: 170,
                height: 170,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: flip ? 0 : 20, right: flip ? 20 : 0, bottom: 20),
            child: Align(
              alignment: flip ? Alignment.bottomLeft : Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                flip ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.white70)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildCategoryCard(
            'Movies',
            '532 Titles',
            'assets/images/rectangle_14.png',
            'assets/images/spider_man.png',
            false,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildCategoryCard(
            'Animes',
            '532 Titles',
            'assets/images/rectangle_15.png',
            'assets/images/deku.png',
            true,
          ),
        ),
      ],
    );
  }
}
