import 'package:flutter/material.dart';
import 'package:crypto_vault/util/responsive.dart';
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

  static const List<Widget> _screenList = [
    CryptoScreen(),
    SwapScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);

    return Scaffold(
      backgroundColor: Color(0xffE9EDF3FF),
      body:
          Column(
            children: [
              AppBar(
                title: const Text('Crypto Vault'),
                centerTitle: true,
                backgroundColor: Color(0xff6200ee),
              ),
              _screenList[_selectedIndex],
            ],
          ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Color(0xfff9aa33),
        onTap: _onItemTapped,
      ),
    );
  }
}
