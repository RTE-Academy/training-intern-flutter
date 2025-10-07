import 'package:flutter/material.dart';

class MovieOverviewWidget extends StatefulWidget {
  final String? overview;
  final int maxLines;

  const MovieOverviewWidget({
    Key? key,
    this.overview,
    this.maxLines = 5,
  }) : super(key: key);

  @override
  State<MovieOverviewWidget> createState() => _MovieOverviewWidgetState();
}

class _MovieOverviewWidgetState extends State<MovieOverviewWidget> {
  bool _isExpanded = false;
  bool _isTextOverflowing = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.overview;
    if (text == null || text.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final textSpan = TextSpan(
              text: text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            );

            final textPainter = TextPainter(
              text: textSpan,
              maxLines: widget.maxLines,
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth);

            // Kiểm tra xem text có bị cắt không
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                final isOverflowing = textPainter.didExceedMaxLines;
                if (_isTextOverflowing != isOverflowing) {
                  setState(() => _isTextOverflowing = isOverflowing);
                }
              }
            });

            return Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            );
          },
        ),
        if (_isTextOverflowing)
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text(
                    _isExpanded ? 'See less' : 'See more',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.blueAccent,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}