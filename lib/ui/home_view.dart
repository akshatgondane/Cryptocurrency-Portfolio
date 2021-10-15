import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/add_view.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState()
  {
    getValues();
  }

  getValues() async
  {

    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    setState(() {

    });
    print("Bitcoin: " + bitcoin.toString());
    print("Ethereum: " + ethereum.toString());
    print("Tether: " + tether.toString());


  }


  @override
  Widget build(BuildContext context) {



    getValue(String id, double amount)
    {

      if(id.toLowerCase() == 'bitcoin')
        {
          return bitcoin * amount;
        }
      else if(id.toLowerCase() == "tether")
        {
          return tether * amount;
        }
      else
        {
          return ethereum * amount;
        }
    }
    return Scaffold(
      appBar: new AppBar(
        title: new Text("DashBoard"),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        decoration: BoxDecoration(color: Colors.white),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection("Coins").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
              {
                if(!snapshot.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  }

                return ListView(
                  children: snapshot.data!.docs.map((document)
                  {
                    return Padding(padding: EdgeInsets.only(
                      top: 5.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.3,
                      height: MediaQuery.of(context).size.height/12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 5.0,),
                          Text("${document.id}",
                            style: new TextStyle(color: Colors.white, fontSize: 18.0),),
                          Text("₹${getValue(document.id, (document.data() as Map<String, dynamic>)['Amount']).toStringAsFixed(2)}",
                              style: new TextStyle(color: Colors.white, fontSize: 18.0)),
                          IconButton(
                              onPressed: () async => await removeCoin(document.id),
                              icon: Icon(Icons.close, color: Colors.red,)
                          )
                        ],
                      ),
                    ),);
                  }).toList(),
                );
              }
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddView()));
        },
        child: Icon(Icons.add, color: Colors.white),

      ),
      );


  }
}
