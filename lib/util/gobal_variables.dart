int cashAviable = 12500;
String reqUrl = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,binancecoin,cardano,solana,ripple,polkadot';
late String prices;
List priceCryptos = [];