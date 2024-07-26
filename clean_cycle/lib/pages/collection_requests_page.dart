import 'package:flutter/material.dart';

class CollectionRequestsPage extends StatelessWidget {
  const CollectionRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Collection Requests"),
      ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Collections Picked Up
           Container(
            height: 200,
            width: 200,
            color: Theme.of(context).colorScheme.primary,
           ),

            // Collections Dropped Off
            Container(
              height: 200,
              width: 200,
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "Collections\nDropped Off",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
          ),
        );
  }
}
