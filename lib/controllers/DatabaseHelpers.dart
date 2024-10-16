import 'dart:convert';

import 'package:http/http.dart' as http;
class DataBaseHelper{

  // addProduit- CRUD
  Future<http.Response>  addProduit(String nomController, String prixController, valCategorie) async {

    var url = Uri.parse("http://192.168.1.172:4200/api/addProdApi");

    var cat =
    {
      //"id":valCategorie,
      "nom":valCategorie
  }
     ;

    Map data = {
      "nom":"$nomController",
      "prix":"$prixController",
      "categorie": cat
    };
    print('=====dans add');
    print(valCategorie);
    var body = json.encode(data);
    print('==data==');
    print(data);
    print(body);
    var response = await http.post(url, headers:{"Content-Type": "application/json"}, body: body );
    print(response);
    print("=====================");
    print("${response.statusCode}");
    print("${response.body}");

    return response;
  }

  // updateProduit- CRUD
  Future<http.Response>  editerProduit(String id,String nomController, String prixController) async {
    int idProd = int.parse(id);
    print(idProd);
    var url = Uri.parse("http://192.168.1.172:4200/api/editerProduit");
    Map data = {
      "id":"$id",
      "nom":"$nomController",
      "prix":"$prixController"
    };
    var body = json.encode(data);
    var response = await http.put(url,
        headers:{"Content-Type": "application/json"}, body: body );
    print("${response.statusCode}");
    print("${response.body}");

    return response;
  }

//DeleteProduit-CRUD
Future<http.Response>  suprimerProduit(String id) async {
  int idProd = int.parse(id);
  print(idProd);
  var url = Uri.parse("http://192.168.1.172:4200/api/deleteProdApi/$idProd");

  var response = await http.delete(url,
      headers:{"Content-Type": "application/json"});
  print("${response.statusCode}");
  print("${response.body}");

  return response;
}
}