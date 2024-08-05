import 'package:flutter/material.dart';

class CollectionRequestsPage extends StatelessWidget {
  const CollectionRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF4F4),
      // App Bar
      appBar: AppBar(
        backgroundColor: Color(0xFFE1F0E5),
        title: Center(
          child: const Text(
              "Collection Requests",
              style: TextStyle(
              color: Color(0xFF1F3024),
            ),
          ),
        ),
      ),
        body: Padding(
          padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Search Catalog
                      Container(
                        width: 320,
                        height: 120,
                        margin: EdgeInsets.only(bottom:25),
                        decoration: ShapeDecoration(
                          color: Color(0xFF1F3024),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 3,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFFD0E5E5),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // search icon
                             Icon(
                               Icons.search,
                               color: Theme.of(context).colorScheme.tertiary,
                               size: 25,
                               weight: 700,
                             ),

                             // catalog title
                             Padding(
                              padding: EdgeInsets.only(right: 50),
                              child:Text(
                                ' CATALOG',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                  letterSpacing: 2.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Collections Picked Up
                     Container(
                       width: 150,
                       height: 160,
                       decoration: ShapeDecoration(
                         color: Color(0xFFE1F0E5),
                         shape: RoundedRectangleBorder(
                           side: BorderSide(
                             width: 3,
                             strokeAlign: BorderSide.strokeAlignOutside,
                             color: Color(0xFFD0E4E4),
                           ),
                           borderRadius: BorderRadius.circular(30),
                         ),
                       ),
                     ),

                      // Collections Dropped Off
                      Container(
                        width: 150,
                        height: 160,
                        decoration: ShapeDecoration(
                          color: Color(0xFFE1F0E5),
                          shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 3,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFFD0E4E4),
                            ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      ),
                    ],
                  ),
                ],
              ),
        ),
    );
  }
}
