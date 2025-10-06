import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String? avatarUrl;
  final VoidCallback? onMenuTap;

  const HomeHeader({
    Key? key,
    required this.userName,
    this.avatarUrl,
    this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl!)
                : const NetworkImage('https://i.pravatar.cc/150?img=1'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onMenuTap ?? () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}