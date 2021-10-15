import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async
{
  try
  {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  }
  catch(e)
  {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async
{
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch(e)
  {
    if(e.code == 'weak-password')
      {
        print("The password provided is too weak");
      }
    else if(e.code == 'email-already-in-use')
      {
        print('The account already exists for that email');
      }
    return false;
  }
  catch(e)
  {
    print(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async
{
  try
  {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Coins').doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if(!snapshot.exists)
        {
          documentReference.set({'Amount': value});
          return true;
        }
      double newAmount = (snapshot.data() as Map<String, dynamic>)['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
    return true;
  }
  catch(e)
  {
    return false;
  }
}

Future<bool> removeCoin(String id) async
{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance.collection("Users").doc(uid).collection("Coins").doc(id).delete();
  return true;
}

Future<double> getNetPriceChange(String id) async
{
  double netChange = 0.0;
  try
  {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Coins').doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if(!snapshot.exists)
      {
        return 0.0;
      }
      double amount = (snapshot.data() as Map<String, dynamic>)['Amount'];
      netChange = amount * await(getPriceChange(id.toLowerCase()));
      print("Price change from flutterfire: " + netChange.toString());
    });
  }
  catch(e)
  {
    print(e.toString());
  }
  return netChange;
}


