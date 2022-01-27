import 'package:crypto_vault/util/gobal_variables.dart';
import 'package:crypto_vault/util/responsive.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);

    return Column(
      children: [
        const Text('Wallet!',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold
        )),
        const Text('USD Cash',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
            )),
        SizedBox(height: responsive.ip(2)),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              height: responsive.ip(6),
              width: responsive.wp(96),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: responsive.ip(50),
                    width: responsive.wp(10),
                    child: Image.network('https://image.flaticon.com/icons/png/512/25/25228.png'),
                  ),
                  SizedBox(width: responsive.wp(4)),
                  const Text('USD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: responsive.wp(10)),
                  Text(oCcy.format(cashAviable),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            )
        ),
        SizedBox(height: responsive.ip(2)),
        const Text('Cryptos',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
            )),
        ListView.builder(
            itemCount: priceCryptos.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index){
              return SingleChildScrollView(
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              Text(priceCryptos[index]['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                child: Text(wallet['balances'][index].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
}

