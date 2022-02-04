import 'package:ennea_wallet/screens/create_wallet_screen.dart';
import 'package:ennea_wallet/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    FlutterSecureStorage _storage = const FlutterSecureStorage();
    Widget route;

    if(await _storage.containsKey(key: "active_wallet_address")){
      String? activeWalletAddress = await _storage.read(key: "active_wallet_address");
      route = HomeScreen(walletAddress: activeWalletAddress);
    } else {
      route = const CreateWalletScreen();
    }

    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => route)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9EAE1),
      child: Center(
        child: Image.asset(
          "assets/images/logo256-circle.png",
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
