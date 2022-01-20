import 'package:crypto_vault/util/custom_dialog.dart';
import 'package:crypto_vault/util/gobal_variables.dart';
import 'package:crypto_vault/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  int priceToSwap = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);
    return Column(
     children: [
       SizedBox(height: responsive.ip(8),
       child:Column(
         children: [
           const Text('Current Balance',
             style: TextStyle(
                 color: Colors.black,
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
                 color: Colors.black
             ),
           ),
         ],
       )),
       Text('\$${oCcy.format(priceToSwap).toString()}',
        style: const TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold
        ),
       ),
       SizedBox(height: responsive.ip(14)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           FlatButton(
               onPressed:(){
                 addNum(1);
                 },
               child: const Text(
                 '1',
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
                 ),
               ),
           ),
           FlatButton(
             onPressed: (){
               addNum(2);
             },
             child: const Text(
                 '2',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
           FlatButton(
             onPressed: (){
               addNum(3);
             },
             child: const Text(
                 '3',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
         ],
       ),
       SizedBox(height: responsive.ip(6)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           FlatButton(
             onPressed: (){
               addNum(4);
             },
             child: const Text(
               '4',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
           FlatButton(
             onPressed: (){
               addNum(5);
             },
             child: const Text(
               '5',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
           FlatButton(
             onPressed: (){
               addNum(6);
             },
             child: const Text(
               '6',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
         ],
       ),
       SizedBox(height: responsive.ip(6)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           FlatButton(
             onPressed:(){
               addNum(7);
             },
             child: const Text(
               '7',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
           FlatButton(
             onPressed:(){
               addNum(8);
             },
             child: const Text(
               '8',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
           FlatButton(
             onPressed: (){
               addNum(9);
             },
             child: const Text(
               '9',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
         ],
       ),
       SizedBox(height: responsive.ip(6)),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           FlatButton(
             onPressed: (){
               setState(() {
                 priceToSwap = 0;
               });
             },
             child: const Text(
               'X',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30
               ),
             ),
           ),
           FlatButton(
             onPressed: (){
               addNum(0);
             },
             child: const Text(
               '0',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
               ),
             ),
           ),
           FlatButton(
             onPressed: deleteNum,
             child: const Text(
               '<',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 38
               ),
             ),
           ),
         ],
       )

     ],
   );
  }

  deleteNum(){
    int characters = priceToSwap.toString().length;
    String tempPrice;
    if(priceToSwap < 9){
      setState(() {
        priceToSwap = 0;
      });
    }else {
      setState(() {
        tempPrice = priceToSwap.toString().substring(0, characters - 1);
        priceToSwap = int.parse(tempPrice);
      });
    }
  }

  addNum(int number){
    String numberAdd = number.toString();
    String priceS = priceToSwap.toString();
    if(int.parse('$priceS$numberAdd') > cashAviable ){
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
    if (!mounted) return;
    setState(() {
      priceToSwap = int.parse('$priceS$numberAdd');
    });
    }
  }
}