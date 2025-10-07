import 'package:flutter/material.dart';
import '../../domain/entities/cast.dart';

class CastItemWidget extends StatelessWidget {
  final Cast cast;

  const CastItemWidget({
    Key? key,
    required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white24,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: cast.profilePath != null
                ? NetworkImage(
                'https://image.tmdb.org/t/p/w185${cast.profilePath}')
                : null,
            backgroundColor: Colors.grey.shade800,
            child: cast.profilePath == null
                ? Icon(
              Icons.person,
              color: Colors.grey.shade600,
              size: 35,
            )
                : null,
          ),
        ),
        const SizedBox(height: 8),

        // Actor name
        SizedBox(
          width: 80,
          child: Text(
            cast.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}