import 'package:bip39/bip39.dart' as bip39;
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:ennea_wallet/db/repository/wallet_repository.dart';
import 'package:ennea_wallet/model/wallet.dart' as wallet;
import 'package:ennea_wallet/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/credentials.dart';

class MyWallet {

  late FlutterSecureStorage _storage;

  MyWallet(){
    _storage = const FlutterSecureStorage();
  }

  createWallet(menomics, name, {onFinish}) async {

    String seed = bip39.mnemonicToSeedHex(menomics);
    Chain chain = Chain.seed(seed);
    ExtendedPrivateKey key = chain.forPath("m/44'/60'/0'/0/0") as ExtendedPrivateKey;
    EthPrivateKey credentials = EthPrivateKey.fromHex(key.privateKeyHex());
    EthereumAddress walletAddress = credentials.address;

    List<wallet.Wallet> wallets = await WalletRepository().readAllWallets() as List<wallet.Wallet>;

    wallet.Wallet w = wallet.Wallet(
      walletMenomics: menomics,
      walletName: name == null ? "Wallet - ${wallets.length + 1}" : name.toString(),
      walletAddress: walletAddress.toString(),
      walletPrivateKey: key.privateKeyHex()
    );

    await WalletRepository().addWallet(w);
    await changeWallet(w.walletAddress, onFinish: () {
      onFinish(w.walletAddress);
    });
  }

  changeWallet(walletAddress, {onFinish}) async {
    await _storage.write(key: "active_wallet_address", value: walletAddress);
    onFinish();
  }

}