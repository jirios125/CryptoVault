import 'dart:convert';
import 'package:crypto_vault/util/custom_dialog.dart';
import 'package:crypto_vault/util/gobal_variables.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPrices();
    var responsive = Responsive(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: responsive.ip(28),
              ),
              creditCard(),
            ],
          ),
          cryptoPriceList(),
        ],
      ),
    );
  }

  void getPrices() async{
    try{
      var response = await http.get(Uri.parse(reqUrl));
      var rb = response.body;
      setState(() {
        priceCryptos = json.decode(rb) as List;
      });
      print('Crypto prices refreshed!');
    } catch(e){
      print(e);
    }
  }

  Widget cryptoPriceList(){
    var responsive = Responsive(context);

    return ListView.builder(
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
                SizedBox(width: responsive.wp(1.2)),
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
    );
  }

  Widget creditCard(){
    final _usdAdd = TextEditingController();
    var responsive = Responsive(context);
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://lh3.googleusercontent.com/ZdMdznf08GDWOLY3pKfjQudbAxxQkFQ5ydRIc21BO1kHyTayTafKzz9hLw7izP3AeQ=w800-h500-rw',
                  width: responsive.wp(98),
                ),
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
                          const Text('Current Balance',
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
          Positioned(
            bottom: 35,
            right: 24,
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: responsive.ip(7),
                  width: responsive.wp(20),
                  child: ElevatedButton(
                      onPressed: (){
                        showDialog(context: context, builder: (context) =>
                            AlertDialog(
                              title: const Text('Charge money!'),
                              content: TextField(
                                controller: _usdAdd,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Add money',
                                    hintStyle: TextStyle(color:Color(0xff707CFF))
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Accept'),
                                  onPressed: (){
                                    setState(() {
                                      cashAviable = cashAviable + int.parse(_usdAdd.text);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            )
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20)),
                      child: const Icon(Icons.arrow_circle_down_sharp,
                        color: Colors.black,
                        size: 30,
                      )),
                ),
                SizedBox(width: responsive.wp(12)),
                SizedBox(
                  height: responsive.ip(7),
                  width: responsive.wp(20),
                  child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20)),
                      child: const Icon(Icons.arrow_circle_up_sharp,
                        color: Colors.black,
                        size: 30,
                      )),
                ),
                SizedBox(width: responsive.wp(12)),
                SizedBox(
                  height: responsive.ip(7),
                  width: responsive.wp(20),
                  child: ElevatedButton(
                      onPressed: getPrices,
                      style: ElevatedButton.styleFrom(primary: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20)),
                      child: const Icon(Icons.refresh,
                        color: Colors.black,
                        size: 30,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}