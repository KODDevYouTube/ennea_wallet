// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ennea_wallet/db/db_consts.dart';

class Token {

  var tokenId;
  var tokenContractAddress;
  var tokenAbi;
  var tokenName;
  var tokenSymbol;
  var tokenDecimals;

  Token({
    this.tokenId,
    this.tokenContractAddress,
    this.tokenAbi,
    this.tokenName,
    this.tokenSymbol,
    this.tokenDecimals
  });

  Map<String, dynamic> toMap() {
    return {
      TOKEN_ID: tokenId,
      TOKEN_CONTRACT_ADDRESS: tokenContractAddress,
      TOKEN_ABI: tokenAbi,
      TOKEN_NAME: tokenName,
      TOKEN_SYMBOL: tokenSymbol,
      TOKEN_DECIMALS: tokenDecimals,
    };
  }

}