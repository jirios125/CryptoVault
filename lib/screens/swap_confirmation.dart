import 'dart:convert';
import 'dart:ffi';

import 'package:crypto_vault/util/custom_dialog.dart';
import 'package:crypto_vault/util/gobal_variables.dart';
import 'package:crypto_vault/util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Swap extends StatefulWidget {
  final String from;
  final String to;
  final int priceSwap;
  final String cryptoSwap;
  const Swap({Key? key, required this.from, required this.to, required this.priceSwap, required this.cryptoSwap}) : super(key: key);


  @override
  State<Swap> createState() => _Swap();
}

class _Swap extends State<Swap> {
  String? fromImg;
  String? toImg;
  double priceFrom = 0.0;
  double priceTo = 0.0;
  double receive = 0.0;
  bool isUsdToCrypto = true;


  @override
  void initState() {
    super.initState();
    lookForImg();
  }

  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);
    lookForPrices();
    getPrices();
    return Scaffold(
      backgroundColor: const Color(0xffe9edf3ff),
      appBar: AppBar(
        title: const Text('Crypto Vault'),
        centerTitle: true,
        backgroundColor: const Color(0xff6200ee),
      ),
      body: Column(
        children: [
          SizedBox(
              height: responsive.ip(3),
              width: responsive.wp(100)),
          const Text('Confirm your Swap!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40
          )),
          SizedBox(height: responsive.ip(3)),
          SizedBox(
              height: responsive.ip(10),
              width: responsive.wp(96),
            child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              ),
            child:
                Row(
                  children: [
                    SizedBox(width: responsive.wp(4)),
                    const Text('From',
                        style:TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        )),
                    SizedBox(width: responsive.wp(2)),
                    SizedBox(
                        height: responsive.ip(6),
                        child: Image.network(fromImg.toString())),
                    Text(widget.from,
                        style:const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )),
                    SizedBox(width: responsive.wp(4)),
                    const Text('You will sell',
                        style:TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        )),
                    SizedBox(width: responsive.wp(4)),
                    isUsdToCrypto
                        ?Text('\$${widget.priceSwap.toString()}',
                        style:const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ))
                        :Text(widget.cryptoSwap.toString(),
                        style:const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ))
                  ],
                  ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: const Icon(Icons.arrow_downward_rounded)),
          SizedBox(
            height: responsive.ip(10),
            width: responsive.wp(96),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child:
              Row(
                children: [
                  SizedBox(width: responsive.wp(4)),
                  const Text('To',
                      style:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      )),
                  SizedBox(width: responsive.wp(2)),
                  SizedBox(
                      height: responsive.ip(6),
                      child: Image.network(toImg.toString())),
                  Text(widget.to,
                      style:const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )),
                  SizedBox(width: responsive.wp(4)),
                  const Text('You will receive',
                      style:TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      )),
                  calcToPrice(),
                  SizedBox(width: responsive.wp(4)),
                ],
              ),
            ),
          ),
          confirmButton(),
        ],
      ),
    );
  }

  lookForImg(){
    if(widget.cryptoSwap != '0.0'){
      setState(() {
        isUsdToCrypto = false;
      });
    }
    if(widget.from == 'USD'){
      fromImg = 'https://image.flaticon.com/icons/png/512/25/25228.png';
    }
    for (var i = 0; i < priceCryptos.length; i++) {
      if(widget.to == priceCryptos[i]['name']){
        toImg = priceCryptos[i]['image'];
        }
      if(widget.from == priceCryptos[i]['name']){
        fromImg = priceCryptos[i]['image'];
        }
      }
  }

  lookForPrices(){
    String? tempPF;
    String? tempPT;
    if(widget.from == 'USD'){
      tempPF = widget.priceSwap.toString();
      priceFrom = double.parse(tempPF.toString());
    }
    for (var i = 0; i < priceCryptos.length; i++) {
        if(widget.from == priceCryptos[i]['name']){
          setState(() {
            tempPF = priceCryptos[i]['current_price'].toString();
            priceFrom = double.parse(tempPF.toString());
          });
        }
      if(widget.to == priceCryptos[i]['name']){
        setState(() {
          tempPT = priceCryptos[i]['current_price'].toString();
          priceTo = double.parse(tempPT.toString());
        });
      }
    }
  }

  Widget calcToPrice (){
    return Text(receive.toStringAsFixed(8),
      style: const TextStyle(
        fontWeight: FontWeight.bold
      ));
  }

  confirmSwap(){
    setState(() {
      receive = priceFrom / priceTo;
    });
    if(widget.from == 'USD'){
      setState(() {
        cashAviable = cashAviable - priceFrom.toInt();
      });
    }else{
      for (var i = 0; i < wallet['names'].length; i++) {
        if(widget.from == wallet['names'][i]){
          setState(() {
            wallet['balances'][i] = wallet['balances'][i] - priceFrom;
          });
          }
        }
      }
    for (var i = 0; i < wallet['names'].length; i++){
      if(widget.to == wallet['names'][i]){
        setState(() {
          wallet['balances'][i] = wallet['balances'][i] + receive;
        });
      }
    }
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

  Widget confirmButton(){
    var responsive = Responsive(context);
    return SizedBox(
      height: responsive.ip(8),
      width: responsive.wp(96),
      child: Card(
        child: TextButton(onPressed: (){
          confirmSwap();
        },
            child: Text('Confirm Swap')
        ),
      ),
    );
  }
}


