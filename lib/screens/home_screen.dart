import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto_vault/util/gobal_variables.dart';
import 'package:flutter/material.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  static const List<Widget> _screenList = [
    CryptoScreen(),
    SwapScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9edf3ff),
      body:
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  title: const Text('Crypto Vault'),
                  centerTitle: true,
                  backgroundColor: const Color(0xff6200ee),
                ),
                _screenList[_selectedIndex],
              ],
            ),
          ),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav(){
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.stairs),
          label: 'Crypto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horizontal_circle_outlined),
          label: 'Swap',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xfff9aa33),
      onTap: _onItemTapped,
    );
  }
}


