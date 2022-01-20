import 'dart:convert';
import 'package:resep_makanan/model/resep.api.dart';
import 'package:http/http.dart' as http;
import 'package:resep_makanan/model/resep.dart';

class ResepApi {
// var req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

// req.query({
  // "limit": "18",
  // "start": "0",
  // "tag": "list.recipe.popular"
// });

// req.headers({
// "x-rapidapi-host": "yummly2.p.rapidapi.com",
// "x-rapidapi-key": "e387c50165msh594ec686865b579p1b4eacjsnfe2fa0255a31",
// "useQueryString": true
// });

  static Future<List<Resep>> getResep() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"start": "0", "limit": "18", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "e387c50165msh594ec686865b579p1b4eacjsnfe2fa0255a31",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);

    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Resep.resepFromSnapshot(_temp);
  }
}
