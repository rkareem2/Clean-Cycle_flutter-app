import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  final String? imageUrl;

  const MyDrawerTile({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: ListTile(
        leading: imageUrl != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(imageUrl!),
              )
            : Icon(
                icon,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        onTap: onTap,
      ),
    );
  }
}
