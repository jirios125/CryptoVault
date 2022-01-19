import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

//Clase que se utiliza para tener medidas responsivas segun el tamaño del display actual

class Responsive{
 double width = 0.0;
 double height = 0.0;
 double inch = 0.0;

  Responsive (BuildContext context){
    final size= MediaQuery.of(context).size;

    width=size.width;
    height= size.height;

    inch= math.sqrt(math.pow(width, 2) + math.pow(height, 2));
  }

  double wp (double percent){
    return width * percent / 100;
  }

  double hp (double percent){
    return height * percent / 100;
  }

  double ip (double percent){
    return inch * percent / 100;
  }

}