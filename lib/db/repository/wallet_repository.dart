import 'package:ennea_wallet/db/db_consts.dart';
import 'package:ennea_wallet/db/repository/repository.dart';
import 'package:ennea_wallet/model/wallet.dart';

class WalletRepository {

  late Repository _repository;
  String table = TABLE_WALLET;

  WalletRepository(){
    _repository = Repository();
  }

  Future<int> addWallet(Wallet wallet) async {
    return await _repository.insertData(table, wallet.toMap());
  }

  readAllWallets() async {
    List<dynamic> list = await _repository.readAllData(table);
    List<Wallet> wallets = [];
    for (var element in list) {
      Wallet wallet = Wallet(
        walletId: element[WALLET_ID],
        walletAddress: element[WALLET_ADDRESS],
        walletMenomics: element[WALLET_MENOMICS],
        walletPrivateKey: element[WALLET_PRIVATE_KEY],
        walletName: element[WALLET_NAME]
      );
      wallets.add(wallet);
    }
    return wallets;
  }

  deleteAllWallets() async {
    return await _repository.deleteAllData(table);
  }

  getWallet(walletAddress) async {
    var connection = await _repository.database;
    List<dynamic> list = await connection.query(table, where: '$WALLET_ADDRESS=?', whereArgs: [walletAddress]);
    var element = list.first;
    print(element);
    return Wallet(
        walletId: element[WALLET_ID],
        walletName: element[WALLET_NAME],
        walletPrivateKey: element[WALLET_PRIVATE_KEY],
        walletAddress: element[WALLET_ADDRESS],
        walletMenomics: element[WALLET_MENOMICS]
    );
  }

  getWalletByMenomics(menomics) async {
    var connection = await _repository.database;
    List<dynamic> list = await connection.query(table, where: '$WALLET_MENOMICS=?', whereArgs: [menomics]);
    if(list.isNotEmpty){
      return true;
    }
    return false;
  }

}