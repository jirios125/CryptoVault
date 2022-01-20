import 'package:crypto_vault/util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text, buttonTextYes, buttonTextNo;
  final VoidCallback onPressedNo, onPressedYes;

  CustomDialog(
      {required this.text,
        required this.buttonTextYes,
        required this.onPressedYes,
        required this.buttonTextNo,
        required this.onPressedNo});

  @override
  Widget build(BuildContext context) {
    if (buttonTextYes != "") {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        child: dialogContentTwoOptions(context),
      );
    }
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      child: dialogContent(context),
    );
  }

  //Crea un pop up con un solo boton (Ok)
  dialogContent(BuildContext context) {
    final responsive = Responsive(context);
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
            left: responsive.wp(2.4),
            right: responsive.wp(2.4),
          ),
          margin: const EdgeInsets.only(top: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: responsive.hp(1)),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.ip(2.2),
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: responsive.hp(6.2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive.wp(12),
                              vertical: responsive.hp(1.4)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side:
                              const BorderSide(color: Color(0xff5189FF))),
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK",
                            style: TextStyle(
                                fontSize: responsive.ip(2.2),
                                color: const Color(0xff5189FF)))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Crea un pop up con dos botones (Yes - No)
  dialogContentTwoOptions(BuildContext context) {
    final responsive = Responsive(context);
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: const EdgeInsets.only(top: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: responsive.hp(1)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: responsive.wp(4)),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.ip(2),
                    color: Colors.grey[800],
                  ),
                ),
              ),
              SizedBox(height: responsive.hp(6.2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: buttonTextNo != "" ? <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: responsive.wp(28),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(responsive.ip(1.4)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Colors.blue)),
                            primary: Colors.white,
                          ),
                          onPressed: onPressedYes,
                          child: Text(buttonTextYes,
                              style: TextStyle(
                                  fontSize: responsive.ip(2),
                                  color: Colors.blue[800]))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: responsive.wp(28),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(responsive.ip(1.4)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: const BorderSide(
                                      color: Colors.blue)),
                              primary: Colors.white),
                          onPressed: onPressedNo,
                          child: Text(buttonTextNo,
                              style: TextStyle(
                                  fontSize: responsive.ip(2),
                                  color: Colors.blue[800]))),
                    ),
                  ),
                ] : <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: responsive.wp(28),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(responsive.ip(1.4)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Colors.blue)),
                            primary: Colors.white,
                          ),
                          onPressed: onPressedYes,
                          child: Text(buttonTextYes,
                              style: TextStyle(
                                  fontSize: responsive.ip(2),
                                  color: Colors.blue[800]))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}