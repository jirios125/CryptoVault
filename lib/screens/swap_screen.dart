import 'package:crypto_vault/util/custom_dialog.dart';
import 'package:crypto_vault/util/gobal_variables.dart';
import 'package:crypto_vault/util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  int priceToSwap =0;
  String cryptoToSwap = '0.0';
  final List<Map> _jsonData = [];
  String? _selected;
  String? _selected2;
  bool coinSelected = false;
  @override
  void initState() {
    super.initState();
    cryptoData();
  }

  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);
    return Column(
     children: [
       SizedBox(height: responsive.ip(8),
       child:Column(
         children: [
           SizedBox(height: responsive.ip(1)),
            coinSelected ?
            Text('Current $_selected2 Balance',
             style: const TextStyle(
                 color: Colors.black,
                 fontSize: 15,
                 fontWeight: FontWeight.bold
             ),
           )
            :const Text('Current USD Balance',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),
           SizedBox(
             height: responsive.ip(0.6),
           ),
           coinSelected
           ? getActualPrice(_selected2)
           :Text('\$${oCcy.format(cashAviable)}',
             style: const TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color: Colors.black
             ),
           ),
         ],
       )),
       SizedBox(
         child:
             coinSelected
                 ?  Text(cryptoToSwap,
               style: const TextStyle(
                   fontSize:65,
                   fontWeight: FontWeight.bold
               ),
             )
              :Text('\$${oCcy.format(priceToSwap).toString()}',
              style: const TextStyle(
                fontSize:65,
                fontWeight: FontWeight.bold
              ),
         ),
       ),
       SizedBox(height: responsive.ip(12),
       child: Row(
         children: [
           SizedBox(width: responsive.wp(2)),
           SizedBox(
             height: responsive.ip(8),
             width: responsive.wp(42),
             child:  Center(
                 child: Card(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                           child: DropdownButtonHideUnderline(
                               child:ButtonTheme(
                                 alignedDropdown: true,
                                 child: DropdownButton(
                                   hint: Text('Select Crypto!'),
                                   value: _selected2,
                                   onChanged: (newValue){
                                     setState(() {
                                       _selected2 = newValue as String?;
                                       if(_selected2 == 'USD'){
                                         coinSelected = false;
                                       }else{
                                         coinSelected = true;
                                       }
                                     });
                                   },
                                   items: _jsonData.map((cryptoItem) {
                                     return DropdownMenuItem(
                                         value: cryptoItem['name'],
                                         child: Row(
                                           children: [
                                             Image.network(cryptoItem['image'],
                                                 width: 20,
                                                 height: 20),
                                             SizedBox(width: responsive.wp(2)),
                                             Text(cryptoItem['name'])
                                           ],
                                         )
                                     );
                                   }).toList(),
                                 ),
                               )
                           )
                       )
                     ],
                   ),
                 )
             ),
           ),
           SizedBox(
             height: responsive.ip(10),
             child: IconButton(onPressed: (){
               setState(() {
                 String? temp;
                 temp = _selected;
                 _selected = _selected2;
                 _selected2 = temp;
               });
             },
                 icon: const Icon(Icons.swap_horiz_rounded)),
           ),
           SizedBox(
             height: responsive.ip(8),
             width: responsive.wp(42),
               child:  Center(
                 child: Card(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                           child: DropdownButtonHideUnderline(
                             child:ButtonTheme(
                               alignedDropdown: true,
                               child: DropdownButton(
                                 hint: Text('Select Crypto!'),
                                 value: _selected,
                                 onChanged: (newValue){
                                   setState(() {
                                     _selected = newValue as String?;
                                   });
                                 },
                                 items: _jsonData.map((cryptoItem) {
                                   return DropdownMenuItem(
                                     value: cryptoItem['name'],
                                       child: Row(
                                         children: [
                                           Image.network(cryptoItem['image'],
                                           width: 20,
                                           height: 20),
                                           SizedBox(width: responsive.wp(2)),
                                           Text(cryptoItem['name'])
                                         ],
                                       )
                                   );
                                 }).toList(),
                               ),
                             )
                           )
                       )
                     ],
                   ),
                 )
               ),
           )
         ],
       )),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           TextButton(
               onPressed:(){
                 addNum(1);
                 },
               child: const Text(
                 '1',
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                     color: Colors.black
                 ),
               ),
           ),
           TextButton(
             onPressed: (){
               addNum(2);
             },
             child: const Text(
                 '2',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
           TextButton(
             onPressed: (){
               addNum(3);
             },
             child: const Text(
                 '3',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
         ],
       ),
       SizedBox(height: responsive.ip(4)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           TextButton(
             onPressed: (){
               addNum(4);
             },
             child: const Text(
               '4',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
           TextButton(
             onPressed: (){
               addNum(5);
             },
             child: const Text(
               '5',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
           TextButton(
             onPressed: (){
               addNum(6);
             },
             child: const Text(
               '6',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
         ],
       ),
       SizedBox(height: responsive.ip(4)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           TextButton(
             onPressed:(){
               addNum(7);
             },
             child: const Text(
               '7',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
           TextButton(
             onPressed:(){
               addNum(8);
             },
             child: const Text(
               '8',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
           TextButton(
             onPressed: (){
               addNum(9);
             },
             child: const Text(
               '9',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
         ],
       ),
       SizedBox(height: responsive.ip(4)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           TextButton(
             onPressed: (){
               if(_selected2 == 'USD'){
                 setState(() {
                   priceToSwap = cashAviable;
                 });
               }else{
                 setState(() {
                   cryptoToSwap = getPrice(_selected2);
                 });
               }
             },
             child: const Text(
               'MAX',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 20,
                   color: Colors.black
               ),
             ),
           ),
           TextButton(
             onPressed: (){
               addNum(0);
             },
             child: const Text(
               '0',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.black
               ),
             ),
           ),
           TextButton(
             onPressed: deleteNum,
             child: const Text(
               '<',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 38,
                   color: Colors.black
               ),
             ),
           ),
         ],
       ),
       SizedBox(height: responsive.ip(0.5)),
       SizedBox(
         height: responsive.ip(8),
         width: responsive.wp(96),
         child: Card(
           child: TextButton(
               onPressed: (){

             },
               child: Text('Next')
           ),
         ),
       )
     ],
   );
  }

  deleteNum(){
    int characters = priceToSwap.toString().length;
    int charactersCrypto = cryptoToSwap.length;
    String tempPrice;
    if(_selected2 != 'USD'){
      if(charactersCrypto <= 3){
        print('Invalid delete');
      }else {
        setState(() {
          tempPrice =
              cryptoToSwap.toString().substring(0, charactersCrypto - 1);
          cryptoToSwap = tempPrice;
        });
      }
    }else {
        if(priceToSwap.toString().length == 1){
          setState(() {
            priceToSwap = 0;
          });
        }else{
        tempPrice = priceToSwap.toString().substring(0, characters - 1);
        setState(() {
          priceToSwap = int.parse(tempPrice);
        });
      }
    }
  }

  addNum(int number){
    String numberAdd = number.toString();
    String priceS = priceToSwap.toString();
    if(double.parse('$priceS$numberAdd') > cashAviable ){
      showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              text: 'Insufficient funds',
              onPressedYes: () {
                Navigator.pop(context);
              },
              onPressedNo: () {
              },
              buttonTextNo: '',
              buttonTextYes: 'Retry',
            );
          });
    }else{
      if(_selected2 == 'USD'){
        setState(() {
          priceToSwap = int.parse('$priceS$numberAdd');
        });
      }else {
        setState(() {
          cryptoToSwap = '$cryptoToSwap$numberAdd';
        });
      }
    }
  }

  cryptoData() {
    dynamic usd = {
      'name': 'USD',
      'image': 'https://image.flaticon.com/icons/png/512/25/25228.png'
    };
    _jsonData.add(usd);
    for (var i = 0; i < priceCryptos.length; i++) {
      dynamic tempData = {
        'name': priceCryptos[i]['name'],
        'image': priceCryptos[i]['image']
      };
      _jsonData.add(tempData);
    }
  }

  Widget getActualPrice(selectedCoin){
    double? coinBalance;
    for (var i = 0; i < wallet['names'].length; i++) {
      if(selectedCoin == wallet['names'][i]) {
        coinBalance = wallet['balances'][i];
        }
    }
      return Text(oCcy.format(coinBalance),
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
    );
  }

  String getPrice(selectedCoin){
    double? coinBalance;
    for (var i = 0; i < wallet['names'].length; i++) {
      if(selectedCoin == wallet['names'][i]) {
        coinBalance = wallet['balances'][i];
      }
    }
    return coinBalance.toString();
  }
}

