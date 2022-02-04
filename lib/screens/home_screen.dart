import 'package:ennea_wallet/screens/create_wallet_screen.dart';
import 'package:ennea_wallet/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {

  String? walletAddress;

  HomeScreen({Key? key, required this.walletAddress}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    const WalletScreen(),
    const CreateWalletScreen()
  ];

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).dialogBackgroundColor,
    ));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _pages.elementAt(_selectedIndex),
            )
          ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 50.0,
        selectedItemColor: Colors.orange,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.account_balance_wallet),
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Wallet"
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings),
            label: "Settings"
          ),
        ],
      ),
    );
  }
}
