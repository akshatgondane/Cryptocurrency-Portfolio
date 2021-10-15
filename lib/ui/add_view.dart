import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = ["Bitcoin", "Ethereum", "Tether"];
  String dropdownValue = "Bitcoin";
  TextEditingController amountController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            items: coins.map<DropdownMenuItem<String>>((String value)
            {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: dropdownValue,
            onChanged: (value)
            {
              setState(() {
                dropdownValue = value!;
              });
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: "Coin Amount",
              ),
            ),
          ),
          SizedBox(height: 15.0,),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,

            ),
            child: MaterialButton(
                onPressed: () async {
                  await addCoin(dropdownValue, amountController.text);
                  Navigator.of(context).pop();
                },
                color: Colors.blue,
                child: new Text("Add")),
          ),
        ],
      )
    );
  }
}
