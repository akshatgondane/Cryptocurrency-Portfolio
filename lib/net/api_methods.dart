import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async
{
  try{
    var url = "https://api.coingecko.com/api/v3/coins/" + id;
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var value = json['market_data']['current_price']['inr'].toString();
    return double.parse(value);
  }
  catch(e)
  {
    print(e.toString());
    return 0.0;
  }
}

Future<double> getPriceChange(String id) async
{
  try{
    var url = "https://api.coingecko.com/api/v3/coins/" + id;
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var value = json['market_data']['price_change_24h_in_currency']['inr'].toString();
    print("Price change from api methods: " + value);
    return double.parse(value);
  }
  catch(e)
  {
    print(e.toString());
    return 0.0;
  }
}