import 'package:clean_cycle/components/chatbot.dart';
import 'package:clean_cycle/components/my_nav-bar.dart';
import 'package:clean_cycle/pages/Collection_Request.dart';
import 'package:clean_cycle/pages/contribute_page.dart';
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
  bool _isChatVisible = false;

  void _toggleChatVisibility() {
    setState(() {
      _isChatVisible = !_isChatVisible;
    });
  }

  final List<Widget> _pages = [
    GoogleMapPage(),
    CollectionRequestsPage(),
    ContributePage(),
    // Add more pages if needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleChatVisibility,
        tooltip: (_isChatVisible ? 'Hide Chat' : 'Ask Gemini'),
        child: const Icon(Icons.chat_bubble),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      drawer: const MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upgrade_sharp),
            label: 'Contribute',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
