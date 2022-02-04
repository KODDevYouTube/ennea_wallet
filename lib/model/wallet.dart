// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ennea_wallet/db/db_consts.dart';

class Wallet {

  final walletId;
  final walletMenomics;
  final walletName;
  final walletAddress;
  final walletPrivateKey;

  const Wallet({
   this.walletId,
   this.walletMenomics,
   this.walletName,
   this.walletAddress,
   this.walletPrivateKey
  });

  Map<String, dynamic> toMap() {
    return {
      WALLET_ID: walletId,
      WALLET_MENOMICS: walletMenomics,
      WALLET_NAME: walletName,
      WALLET_ADDRESS: walletAddress,
      WALLET_PRIVATE_KEY: walletPrivateKey,
    };
  }

}