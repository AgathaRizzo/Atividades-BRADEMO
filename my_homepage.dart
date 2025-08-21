import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomepage 
extends StatelessWidget
{
@override
  Widget build(BuildContext context){
    final mediaQuery =  MediaQuery.of(context);
    final altura = mediaQuery.size.height;
    final largura = mediaQuery.size.width;

   //Cria uma lista com 100 textos
    final myList = List.generate(
      100,
      (index){
        return Text(" Item $index",
        style: TextStyle(
          fontSize: 22
        ),
        );
      },
    );

    return Center(
          child: _createListView(myList)
        );
  }
Widget _createListView(List<Text> myList){
  return ListView.builder(
    itemCount: myList.length,
    itemBuilder: (context, index){
      return myList[index];
    },
  );
}

Widget _createColumn(){
  return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text("$altura x $largura" ),
              Text("Meu App!",
              style: TextStyle(
                fontSize: 32
               ),
              ),
              Text("My App!",
              style: TextStyle(
                fontSize: 32
               ),
              ),
            ],
          );
}
}
