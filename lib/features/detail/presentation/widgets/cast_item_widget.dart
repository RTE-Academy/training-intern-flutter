import 'package:flutter/material.dart';
import '../../../../core/constant/constant_url.dart';
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
            backgroundImage: NetworkImage(
                '$img_url_w185${cast.profilePath}'),
            backgroundColor: Colors.grey.shade800,
            child: null,
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