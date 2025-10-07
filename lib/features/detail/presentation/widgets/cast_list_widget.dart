import 'package:flutter/material.dart';
import '../../domain/entities/cast.dart';
import 'cast_item_widget.dart';

class CastListWidget extends StatelessWidget {
  final List<Cast> cast;

  const CastListWidget({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Cast',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (cast.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'No cast available',
              style: TextStyle(color: Colors.white70),
            ),
          )
        else
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CastItemWidget(cast: cast[index]),
                );
              },
            ),
          ),
      ],
    );
  }
}
