import 'package:ennea_wallet/db/db_consts.dart';
import 'package:ennea_wallet/db/repository/repository.dart';
import 'package:ennea_wallet/model/token.dart';

class TokenRepository {

  late Repository _repository;
  String table = TABLE_TOKEN;

  TokenRepository(){
    _repository = Repository();
  }

  Future<int> addToken(Token token) async {
    return await _repository.insertData(table, token.toMap());
  }

  readAllTokens() async {
    return await _repository.readAllData(table);
  }

  deleteAllTokens() async {
    return await _repository.deleteAllData(table);
  }

  getToken(tokenContractAddress) async {
    var connection = await _repository.database;
    List<dynamic> list = await connection.query(table, where: '$TOKEN_CONTRACT_ADDRESS=?', whereArgs: [tokenContractAddress]);
    var element = list.first;
    print(element);
    return Token(
        tokenId: element[TOKEN_ID],
        tokenName: element[TOKEN_NAME],
        tokenSymbol: element[TOKEN_SYMBOL],
        tokenContractAddress: element[TOKEN_CONTRACT_ADDRESS],
        tokenAbi: element[TOKEN_ABI],
        tokenDecimals: element[TOKEN_DECIMALS]
    );
  }

}