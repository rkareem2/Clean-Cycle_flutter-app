import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? imageUrl;
  final void Function()? onTap;

  const MyDrawerTile({
    super.key,
    required this.text,
    this.icon,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        leading: imageUrl != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(imageUrl!),
              )
            : Icon(
                icon,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
        onTap: onTap,
      ),
    );
  }
}
