
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Caeser extends StatefulWidget {
  const Caeser({super.key});

  @override
  State<Caeser> createState() => _CaeserState();
}

class _CaeserState extends State<Caeser> {
  bool isencrypt=true;
  String result2='';
  var Register_Key = GlobalKey<FormState>() ;

  TextEditingController a1=TextEditingController();//message
  TextEditingController a2=TextEditingController();//key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Caeser'),),
      body: Form(
        key: Register_Key,
        child: SingleChildScrollView(
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
              keyboardType: TextInputType.phone,
              //validator:},
              decoration: InputDecoration(
                  labelText: 'SHIFT',
                  hintText: 'Enter your shift',
                  prefixIcon: Icon(Icons.man_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
              ),
            ),
            SizedBox(height: 20,),
            MaterialButton(onPressed: ()
            {
              setState(() {
                result2=fun(a1.text,int.parse(a2.text));
              });
              result2=fun(a1.text,int.parse(a2.text));

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
    );
  }

  String fun(String msg,int shift)
  {
    String caesarEncrypt(String plaintext, int shift) {
      return String.fromCharCodes(plaintext.runes.map((int charCode) {
        if (charCode >= 65 && charCode <= 90) {
          // Uppercase letters
          return (charCode - 65 + shift) % 26 + 65;
        } else if (charCode >= 97 && charCode <= 122) {
          // Lowercase letters
          return (charCode - 97 + shift) % 26 + 97;
        } else {
          // Non-alphabetic characters remain unchanged
          return charCode;
        }
      }));
    }
    String caesarDecrypt(String ciphertext, int shift) {
      return caesarEncrypt(ciphertext, -shift);
    }
    if (isencrypt) {
      var encryptedText = caesarEncrypt(msg, shift);
      print(encryptedText);
      return encryptedText;
    } else {

      var decryptedText = caesarDecrypt(msg, shift);
      return decryptedText;
    }
  }
}
