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
      backgroundColor: Color(0xffF0F5FD),
      body:
          Column(
            children: [
              AppBar(
                title: const Text('Crypto Vault'),
                centerTitle: true,
                backgroundColor: Color(0xff6200EE),
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
            icon: Icon(Icons.flutter_dash_rounded),
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
