import 'package:clean_cycle/pages/collection_requests_page.dart';
import 'package:clean_cycle/pages/contribute_page.dart';
import 'package:clean_cycle/pages/gemini_page.dart';
import 'package:flutter/material.dart';
import 'package:clean_cycle/components/my_drawer.dart';
import 'package:clean_cycle/pages/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    GoogleMapPage(),
    CollectionRequestsPage(),
    ContributePage(),
    GeminiPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: _selectedIndex == 0 ? const MyDrawer() : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upgrade_sharp),
            label: 'Contribute',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Gemini',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
