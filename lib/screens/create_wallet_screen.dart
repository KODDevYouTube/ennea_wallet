import 'package:ennea_wallet/helper/app_progress_dialog.dart';
import 'package:ennea_wallet/screens/home_screen.dart';
import 'package:ennea_wallet/screens/import_wallet_screen.dart';
import 'package:ennea_wallet/theme/ThemeService.dart';
import 'package:ennea_wallet/util/MyWallet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  _CreateWalletScreenState createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {

  late AppProgressDialog appProgressDialog;

  @override
  void initState() {
    appProgressDialog = AppProgressDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo256-circle.png",
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Ennea Wallet",
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: "AppFont",
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ],
                  )
                ),
              ),
              _bottomButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomButtons(){
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  appProgressDialog.show();
                  String menomics = bip39.generateMnemonic();
                  MyWallet().createWallet(menomics, null, onFinish: (walletAddress) {
                    appProgressDialog.hide();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(walletAddress: walletAddress))
                    );
                  });
                },
                child: const Text("CREATE A NEW WALLET"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      return Colors.orange; // Use the component's default.
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                  text: "I already have a wallet",
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 15
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const ImportWalletScreen())
                      );
                    }
              ),
            ),

            //Need to be deleted
            RichText(
              text: TextSpan(
                  text: "Change Theme",
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 15
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      ThemeService().switchTheme();
                    }
              ),
            )

          ],
        ),
      ),
    );
  }
}
