import 'package:intl/intl.dart';

String reqUrl = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,binancecoin,cardano,solana,ripple,polkadot';
late String prices;
List priceCryptos = [];
final oCcy = new NumberFormat("#,##0.00", "en_US");


//USD Cash Avaiable
int cashAviable = 0;

//Cryptos
dynamic wallet = {
  'names': [],
  'balances': []
};