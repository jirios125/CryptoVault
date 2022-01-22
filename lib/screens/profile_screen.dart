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
        ListView.builder(
            itemCount: priceCryptos.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
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
                              Text(oCcy.format(balances[index]),
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
}

