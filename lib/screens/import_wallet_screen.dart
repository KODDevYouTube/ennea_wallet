import 'package:clipboard/clipboard.dart';
import 'package:ennea_wallet/db/repository/wallet_repository.dart';
import 'package:ennea_wallet/helper/app_progress_dialog.dart';
import 'package:ennea_wallet/helper/toast_message.dart';
import 'package:ennea_wallet/model/wallet.dart';
import 'package:ennea_wallet/screens/home_screen.dart';
import 'package:ennea_wallet/theme/ThemeService.dart';
import 'package:ennea_wallet/util/MyWallet.dart';
import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;

class ImportWalletScreen extends StatefulWidget {
  const ImportWalletScreen({Key? key}) : super(key: key);

  @override
  _ImportWalletScreenState createState() => _ImportWalletScreenState();
}

class _ImportWalletScreenState extends State<ImportWalletScreen> {

  int walletId = 0;
  var nameController = TextEditingController();
  var phraseController = TextEditingController();

  late AppProgressDialog appProgressDialog;

  @override
  void initState() {
    appProgressDialog = AppProgressDialog(context);
    _getWalletId();
    super.initState();
  }

  _getWalletId() async {
    List<Wallet> wallets = await WalletRepository().readAllWallets() as List<Wallet>;
    walletId = wallets.length + 1;
    setState(() {
      nameController.text = "Wallet - $walletId";
    });
  }

  bool _checkPhrase(){
    if(phraseController.text.isNotEmpty){
      List<String> phrases = phraseController.text.split(" ");
      if(phrases.length != 12 && phrases.length != 24){
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  _importWallet(){
    appProgressDialog.show();
    if(nameController.text.isNotEmpty){
      if(_checkPhrase()){
        String menomics = phraseController.text;
        if(bip39.validateMnemonic(menomics)){
          WalletRepository().getWalletByMenomics(menomics).then((value){
            if(value){
              appProgressDialog.hide();
              ToastMessage.showToast("Wallet already is added!");
            } else {
              MyWallet().createWallet(menomics, nameController.text, onFinish: (walletAddress) {
                appProgressDialog.hide();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(walletAddress: walletAddress))
                );
              });
            }
          });
        } else {
          appProgressDialog.hide();
          ToastMessage.showToast("Invalid phrase. Please check again!");
        }
      } else {
        appProgressDialog.hide();
        ToastMessage.showToast("Invalid phrase. Please check again!");
      }
    } else {
      appProgressDialog.hide();
      ToastMessage.showToast("Wallet name must not be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Import Smart Chain BEP-20"),
        backgroundColor: Theme.of(context).dialogBackgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name'
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phraseController,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 5,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                  labelText: 'Phrase',
                  suffixIcon: TextButton(
                    child: const Text(
                      'PASTE',
                      style: TextStyle(
                        color: Colors.orange
                      ),
                    ),
                    onPressed: () {
                      FlutterClipboard.paste().then((value) {
                        setState(() {
                          phraseController.text = value;
                        });
                      });
                    },
                  )
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Typically 12 (sometimes 24) words separated by single spaces",
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _importWallet();
                  },
                  child: const Text("IMPORT"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      return Colors.orange; // Use the component's default.
                    },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
