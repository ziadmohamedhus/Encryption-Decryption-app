
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Algo1.dart';
import 'Caeser.dart';
import 'Mono.dart';


class Start extends StatefulWidget {

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int cur_step=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('START'),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60,),
              Container(
                width: 250,
                  height: 200,
                  child: Image(image: AssetImage('assets/image/encryption.png'))
              ),
              SizedBox(height: 60,),
              Center(
                child: Stepper(
                  steps: [
                    Step(
                        isActive: cur_step==0,
                        title: Text('PLAYFAIR',style: TextStyle(color: HexColor('9F807D')),),
                        content:Text('encryption & decryption',style: TextStyle(color: HexColor('9F807D')),)
                    ),
                    Step(
                        isActive: cur_step==1,
                        title: Text('CAESER',style: TextStyle(color: HexColor('9F807D')),),
                        content:Text('encryption & decryption',style: TextStyle(color: HexColor('9F807D')),)
                    ),
                    Step(
                        isActive: cur_step==2,
                        title: Text('MONOALPHABETIC',style: TextStyle(color: HexColor('9F807D'))),
                        content:Text('encryption & decryption',style: TextStyle(color: HexColor('9F807D')),)
                    ),

                  ],
                  onStepTapped: (int newindex)
                  {
                    setState(() {
                      cur_step=newindex;
                    });
                  },
                  currentStep: cur_step,
                  onStepContinue: (){
                    if(cur_step==0)
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Algo1()));
                       }
                    else if(cur_step==1)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Caeser())) ;
                    }
                    else if(cur_step==2)
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Mono()));
                    }

                  },
                  onStepCancel: (){
                    if(cur_step!=2)
                    { setState(() {
                      cur_step++;
                    });}
                    else if(cur_step==2)
                    {setState(() {
                      cur_step=0;
                    });}
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
