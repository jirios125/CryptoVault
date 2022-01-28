import 'dart:async';
import 'dart:convert';
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
  //Data needed to make the swap
  String? fromImg;
  String? toImg;
  double priceFrom = 0.0;
  double priceTo = 0.0;

  //Receive its what the user will receive after the swap
  double receive = 0.0;

  //Variables
  bool isUsdToCrypto = true;
  int secsLeft = 60;




  @override
  void initState() {
    super.initState();
    lookForImg();
    _startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);
    lookForPrices();
    getPrices();
    updatePrices();
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
          fromCard(),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: const Icon(Icons.arrow_downward_rounded)),
          toCard(),
          SizedBox(height: responsive.ip(33)),
          timeLeft(),
          confirmButton(),
        ],
      ),
    );
  }

  Widget fromCard(){
    var responsive = Responsive(context);
    return SizedBox(
      height: responsive.ip(10),
      width: responsive.wp(96),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  ? Flexible(
                child: Text('\$${widget.priceSwap.toString()}',
                    style:const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    )),
              )
                  : Flexible(
                child: Text(widget.cryptoSwap.toString(),
                    style:const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    )),
                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget toCard(){
    var responsive = Responsive(context);
    return SizedBox(
      height: responsive.ip(10),
      width: responsive.wp(96),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }

  Widget timeLeft(){
    return Center(
      child: Text('You have ${secsLeft.toString()} seconds to confirm the swap before prices change',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  void _startCountDown(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(secsLeft > 0){
        if(mounted) {
          setState(() {
            secsLeft--;
          });
        }
      }else{
        timer.cancel();
      }
    });
  }

  lookForImg(){
    if(widget.cryptoSwap != '0.0'){
      if(mounted) {
        setState(() {
          isUsdToCrypto = false;
        });
      }
    }
    if(widget.from == 'USD'){
      fromImg = 'https://image.flaticon.com/icons/png/512/25/25228.png';
    }
    if(widget.to == 'USD'){
      toImg = 'https://image.flaticon.com/icons/png/512/25/25228.png';
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
          if(mounted) {
            setState(() {
              tempPF = priceCryptos[i]['current_price'].toString();
              priceFrom = double.parse(tempPF.toString());
            });
          }
        }
      if(widget.to == priceCryptos[i]['name']){
        if(mounted) {
          setState(() {
            tempPT = priceCryptos[i]['current_price'].toString();
            priceTo = double.parse(tempPT.toString());
          });
        }
      }
      if(widget.to == 'USD'){
        if(mounted) {
          setState(() {
            priceTo = 1;
          });
        }
      }
    }
  }
  Widget calcToPrice (){
    if(widget.from == 'USD'){
      if(mounted) {
        setState(() {
          receive = priceFrom / priceTo;
        });
      }
    }else{
      for (var i = 0; i < wallet['names'].length; i++) {
        if(widget.from == wallet['names'][i]){
          for (var j = 0; j < priceCryptos.length; j++) {
              if(wallet['names'][i] == priceCryptos[j]['name']){
                double cryptoUsdBalance = 0.0;
                cryptoUsdBalance = wallet['balances'][i] * priceCryptos[j]['current_price'];
                if(mounted){
                  setState(() {
                    receive = (cryptoUsdBalance / priceTo);
                  });
                }
              }
          }
        }
      }
    }

    return Flexible(
      child: Text(receive.toStringAsFixed(8),
        style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold
        )),
    );
  }

  confirmSwap(){
    if(widget.from == 'USD'){
      if(mounted) {
        setState(() {
          cashAviable = cashAviable - widget.priceSwap;
        });
      }
    }else{
      for (var i = 0; i < wallet['names'].length; i++) {
        if(widget.from == wallet['names'][i]){
          if(mounted) {
            setState(() {
              wallet['balances'][i] = wallet['balances'][i] - double.parse(widget.cryptoSwap.toString());
              priceToSwap = 0;
              cryptoToSwap = '0.0';
            });
          }
          }
        }
      }
    if(widget.to == 'USD'){
      setState(() {
        cashAviable = cashAviable + receive.toInt();
      });
    }else {
      for (var i = 0; i < wallet['names'].length; i++) {
        if (widget.to == wallet['names'][i]) {
          if (mounted) {
            setState(() {
              wallet['balances'][i] = wallet['balances'][i] + receive;
            });
          }
        }
      }
    }
  }

  void getPrices() async{
    try{
      var response = await http.get(Uri.parse(reqUrl));
      var rb = response.body;
      if(mounted) {
        setState(() {
          priceCryptos = json.decode(rb) as List;
        });
      }
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
          Navigator.pop(context);
        },
            child: const Text('Confirm Swap')
        ),
      ),
    );
  }

  updatePrices(){
    if(secsLeft == 0){
      getPrices();
      lookForPrices();
      if(mounted) {
        setState(() {
          secsLeft = 60;
        });
      }
    }
  }
}


