import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto_vault/util/responsive.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  int cashAviable = 12500;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  String reqUrl = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,binancecoin,cardano,solana';
  late String prices;
  List priceCryptos = [];


  @override
  Widget build(BuildContext context) {
    getPrices();
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
                        child:
                        Image.network('https://lh3.googleusercontent.com/ZdMdznf08GDWOLY3pKfjQudbAxxQkFQ5ydRIc21BO1kHyTayTafKzz9hLw7izP3AeQ=w800-h500-rw')
                    ),
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
                                    const Text('Available Balance',
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
                                    ),
                                  ],
                                ),
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
        ListView.builder(
            itemCount: priceCryptos.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index){
              return SingleChildScrollView(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                          height: responsive.ip(6),
                          width: responsive.wp(96),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: responsive.ip(50),
                                width: responsive.wp(10),
                                child: Image.network(priceCryptos[index]['image']),
                              ),
                              SizedBox(width: responsive.wp(4)),
                              Text(priceCryptos[index]['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: responsive.wp(10)),
                              Text('\$${oCcy.format(priceCryptos[index]['current_price'])}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                              )
                            ],
                          )
                      ),
                    ),
                    ],
                  ),
              );
            }
        ),

      ],
    );
  }

  void getPrices() async{
    try{
      var response = await http.get(Uri.parse(reqUrl));
      var rb = response.body;
      setState(() {
        priceCryptos = json.decode(rb) as List;
      });
    } catch(e){
      print(e);
    }
  }
}