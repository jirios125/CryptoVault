import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto_vault/util/responsive.dart';
import 'package:intl/intl.dart';


class CryptoScreen extends StatefulWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  late Response response;
  var dio = Dio();
  String reqUrl = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,binancecoin,cardano,solana';
  int cashAviable = 12500;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  
  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: responsive.ip(28),
            ),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                        width: responsive.wp(96),
                        height: responsive.ip(25),
                        child: Image.network('https://lh3.googleusercontent.com/ZdMdznf08GDWOLY3pKfjQudbAxxQkFQ5ydRIc21BO1kHyTayTafKzz9hLw7izP3AeQ=w800-h500-rw')),
                    Container(
                      child: SizedBox(
                        width: responsive.wp(96),
                        height: responsive.ip(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: responsive.ip(2),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: responsive.wp(10)
                                ),
                                Column(
                                  children: [
                                    const Text('Aviable Balance',
                                    style: TextStyle(
                                      color: Color(0xffF0F5FD),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsive.ip(0.6),
                                    ),
                                    Text('\$${oCcy.format(cashAviable)}',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        color: Color(0xffF0F5FD)
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Future <List <dynamic>> getPrices() async {
    try {
      var response = await Dio().get(reqUrl);
      print(response);
    } catch (e) {
      print(e);
    }
    return <dynamic>[response];
  }
}