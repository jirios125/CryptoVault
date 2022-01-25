import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto_vault/util/gobal_variables.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_vault/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
        title: 'Check Balances of your favorite cryptos!',
        body: 'We have the most popular coins in the market ;)',
        image: Center(
          child: Image.asset('assets/1.png'),
        ),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )
        )
    ),
    PageViewModel(
        title: 'We use trusted information',
        body: 'All prices are taken from the CoinGecko API. You can check them here',
        footer: SizedBox(
          height: 45,
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // primary: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 8
            ),
            onPressed: () async {
              const url = 'https://www.coingecko.com/en/api';
              if (await canLaunch(url)) {
              await launch(url);
              } else {
              throw 'Could not launch $url';
              }
            },
            child: const Text("Check Documentation!", style: TextStyle(fontSize: 20),),
          ),
        ),
        image: Center(
          child: Image.asset('assets/2.webp'),
        ),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )
        )
    ),
    PageViewModel(
        title: 'The creator of the app',
        body: 'Im Juani, from Argentina and im a Software Developer since 2019',
        footer: SizedBox(
          height: 45,
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 8
            ),
            onPressed: () {},
            child: const Text("Check my LinkedIn here", style: TextStyle(fontSize: 20)),
          ),
        ),
        image: Center(
          child: Image.asset('assets/3.png'),
        ),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )
        )
    ),
  ];

  @override
  Widget build(BuildContext context) {
    getPrices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to CryptoVault'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(15,15),
            color: Colors.blue,
            activeSize: Size.square(20),
            activeColor: Colors.red,
          ),
          showDoneButton: true,
          done: const Text('Done', style: TextStyle(fontSize: 20),),
          showSkipButton: true,
          skip: const Text('Skip', style: TextStyle(fontSize: 20),),
          showNextButton: true,
          next: const Icon(Icons.arrow_forward, size: 25,),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    setBalances();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void getPrices() async{
    try{
      var response = await http.get(Uri.parse(reqUrl));
      var rb = response.body;
        priceCryptos = json.decode(rb) as List;
      print('Crypto prices refreshed!');
    } catch(e){
      print(e);
    }
  }

  setBalances(){
    List<dynamic> tempBalances = [];
    List<dynamic> tempNames = [];
    for (var i = 0; i < priceCryptos.length; i++) {
      tempBalances.add(0.0);
      tempNames.add(priceCryptos[i]['name']);
    }
      wallet['balances'] = tempBalances;
      wallet['names'] = tempNames;
  }

}