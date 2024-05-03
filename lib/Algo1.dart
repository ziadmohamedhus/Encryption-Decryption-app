
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Algo1 extends StatefulWidget {


  @override
  State<Algo1> createState() => _Algo1State();
}

class _Algo1State extends State<Algo1> {
   bool isencrypt=true;
  String result2='';
  var Register_Key = GlobalKey<FormState>() ;

  TextEditingController a1=TextEditingController();//message
  TextEditingController a2=TextEditingController();//key
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Playfair')),
      body: Form(
        key: Register_Key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Container(
                height: 300,
                child: Expanded(child:
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(

                    child: Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isencrypt=true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: isencrypt?HexColor('9F807D'):Colors.grey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock_outline_rounded,size: 80.0,),
                                SizedBox(height: 10.0,),
                                Text('ENCRYPT',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),)
                              ],),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      Expanded(
                        child:
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isencrypt=false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: isencrypt?Colors.grey:HexColor('9F807D'),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock_open_rounded,size: 80.0,),
                                SizedBox(height: 10.0,),
                                Text('DECRYPT',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),)
                              ],),
                          ),
                        ),
                      ),


                    ],),
                  ),
                )),
              ),
              TextFormField(
                controller: a1,
                //validator:},
                decoration: InputDecoration(
                    labelText: 'Message',
                    hintText: 'Enter your MESSAGE',
                    prefixIcon: Icon(Icons.man_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: a2,
                //validator:},
                decoration: InputDecoration(
                    labelText: 'KEY',
                    hintText: 'Enter your KEY',
                    prefixIcon: Icon(Icons.man_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                ),
              ),
              SizedBox(height: 20,),
              MaterialButton(onPressed: ()
              {
                setState(() {
                  result2=fun(a1.text,a2.text);
                });
                result2=fun(a1.text,a2.text);

              },child: Text('SUBMIT',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),

              SizedBox(height: 20,),
              Stack(
                alignment: Alignment.center,
                children: [

                  Image(image: AssetImage('assets/image/message.png')),
                  Column(
                    children: [
                      Text(a1.text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                      SizedBox(height: 150,),
                      Text(result2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                    ],
                  ),
                ],
              ),

            ],
            ),
          ),
        ),
      ),
    );
  }

  String fun(String msg,String key)
  {
    Iterable<List<String>> chunker(Iterable<String> seq, int size) sync* {
      var it = seq.iterator;
      while (true) {
        var chunk = <String>[];
        for (var i = 0; i < size; i++) {
          if (!it.moveNext()) {
            return;
          }
          chunk.add(it.current);
        }
        yield chunk;
      }
    }

    String prepareInput(String dirty) {
      dirty = dirty.toUpperCase().split('').where((c) => c.contains(RegExp(r'[A-Za-z]'))).join('');
      var clean = '';

      if (dirty.length < 2) {
        return dirty;
      }

      for (var i = 0; i < dirty.length - 1; i++) {
        clean += dirty[i];

        if (dirty[i] == dirty[i + 1]) {
          clean += 'X';
        }
      }

      clean += dirty[dirty.length - 1];

      if (clean.length.isOdd) {
        clean += 'X';
      }

      return clean;
    }

    List<String> generateTable(String key) {
      var alphabet = 'ABCDEFGHIKLMNOPQRSTUVWXYZ';
      var table = <String>[];

      for (var char in key.toUpperCase().split('')) {
        if (!table.contains(char) && alphabet.contains(char)) {
          table.add(char);
        }
      }

      for (var char in alphabet.split('')) {
        if (!table.contains(char)) {
          table.add(char);
        }
      }

      return table;
    }

    String encrypt(String plaintext, String key) {
      var table = generateTable(key);
      var plaintextPrepared = prepareInput(plaintext);
      var ciphertext = '';

      for (var chunk in chunker(plaintextPrepared.split(''), 2)) {
        var char1 = chunk[0];
        var char2 = chunk[1];

        var row1 = table.indexOf(char1) ~/ 5;
        var col1 = table.indexOf(char1) % 5;
        var row2 = table.indexOf(char2) ~/ 5;
        var col2 = table.indexOf(char2) % 5;

        if (row1 == row2) {
          ciphertext += table[row1 * 5 + (col1 + 1) % 5];
          ciphertext += table[row2 * 5 + (col2 + 1) % 5];
        } else if (col1 == col2) {
          ciphertext += table[((row1 + 1) % 5) * 5 + col1];
          ciphertext += table[((row2 + 1) % 5) * 5 + col2];
        } else {
          ciphertext += table[row1 * 5 + col2];
          ciphertext += table[row2 * 5 + col1];
        }
      }

      return ciphertext;
    }

    String decrypt(String ciphertext, String key) {
      var table = generateTable(key);
      var plaintext = '';

      for (var chunk in chunker(ciphertext.split(''), 2)) {
        var char1 = chunk[0];
        var char2 = chunk[1];

        var row1 = table.indexOf(char1) ~/ 5;
        var col1 = table.indexOf(char1) % 5;
        var row2 = table.indexOf(char2) ~/ 5;
        var col2 = table.indexOf(char2) % 5;

        if (row1 == row2) {
          plaintext += table[row1 * 5 + (col1 - 1) % 5];
          plaintext += table[row2 * 5 + (col2 - 1) % 5];
        } else if (col1 == col2) {
          plaintext += table[((row1 - 1) % 5) * 5 + col1];
          plaintext += table[((row2 - 1) % 5) * 5 + col2];
        } else {
          plaintext += table[row1 * 5 + col2];
          plaintext += table[row2 * 5 + col1];
        }
      }

      return plaintext;
    }

    if (isencrypt) {

      var result = encrypt(msg, key);
      print(result);
      return result;
    } else {

      var result = decrypt(msg, key);
      return result;
    }
  }
}
