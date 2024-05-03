
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Mono extends StatefulWidget {
  const Mono({super.key});

  @override
  State<Mono> createState() => _MonoState();
}

class _MonoState extends State<Mono> {
  bool isencrypt=true;
  String result2='';
  var Register_Key = GlobalKey<FormState>() ;

  TextEditingController a1=TextEditingController();//message

  TextEditingController a2=TextEditingController();//key



  @override
  Widget build(BuildContext context) {
    a2.text='zyxwvutsrqponmlkjihgfedcba';
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
                  result2=fun(a1.text);
                });
                result2=fun(a1.text);

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

  String fun(String msg)
  {
    void validateKey(String key) {
      String alphabet = "abcdefghijklmnopqrstuvwxyz";
      if (key.length != alphabet.length || !Set.from(key.split('')).containsAll(Set.from(alphabet.split('')))) {
        throw Exception("Invalid key. The key must contain all letters of the alphabet exactly once.");
      }
    }
    String encrypt(String plaintext) {
      String alphabet = "abcdefghijklmnopqrstuvwxyz";
      String key = "zyxwvutsrqponmlkjihgfedcba"; // Example key, you can use your own
      validateKey(key);
      String encryptedText = "";
      for (int i = 0; i < plaintext.length; i++) {
        String char = plaintext[i].toLowerCase();
        int index = alphabet.indexOf(char);

        if (index != -1) {
          String encryptedChar = key[index];
          encryptedChar =
          plaintext[i].toUpperCase() == plaintext[i] ? encryptedChar.toUpperCase() : encryptedChar;
          encryptedText += encryptedChar;
        } else {
          encryptedText += char;
        }
      }
      return encryptedText;
    }

    String decrypt(String ciphertext) {
      String alphabet = "abcdefghijklmnopqrstuvwxyz";
      String key = "zyxwvutsrqponmlkjihgfedcba"; // Example key, you can use your own

      validateKey(key);

      String decryptedText = "";

      for (int i = 0; i < ciphertext.length; i++) {
        String char = ciphertext[i].toLowerCase();
        int index = key.indexOf(char);

        if (index != -1) {
          String decryptedChar = alphabet[index];
          decryptedChar =
          ciphertext[i].toUpperCase() == ciphertext[i] ? decryptedChar.toUpperCase() : decryptedChar;
          decryptedText += decryptedChar;
        } else {
          decryptedText += char;
        }
      }
      return decryptedText;
    }
    if (isencrypt) {
      String encryptedText = encrypt(msg);
      print(encryptedText);
      return encryptedText;
    } else {

      String decryptedText = decrypt(msg);
      return decryptedText;
    }
  }
}
