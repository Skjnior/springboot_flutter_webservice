import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../controllers/DatabaseHelpers.dart';

class AddProduitPage extends StatefulWidget {
  const AddProduitPage({super.key});

  @override
  State<AddProduitPage> createState() => _AddProduitPageState();
}

class _AddProduitPageState extends State<AddProduitPage> {

  DataBaseHelper dbhelp = DataBaseHelper();

  var _baseUrl = Uri.parse("http://192.168.1.172:4200/api/listeCategApi");
  var valCategorie ;
  var idCateg;
  List dataCategorie = [] ;
  void getCategories() async {
    final respose = await http.get(_baseUrl ); //untuk melakukan request ke webservice
    print("-------------categorie--------");
    print(respose.body);
    var listData = jsonDecode(respose.body); //lalu kita decode hasil datanya
    setState(() {
      dataCategorie = listData; // dan kita set kedalam variable _dataProvince
    });
    print("data : $dataCategorie");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prixController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(top: 62,left: 12,right: 12,bottom: 12),
          children: [
            Container(
              height: 50,
              child: TextField(
                controller: nomController,
                decoration: InputDecoration(
                  labelText: "Nom",
                  hintText: "Votre nom",
                  icon: Icon(Icons.person_pin_rounded),
                    border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 50,
              child: TextField(
                controller: prixController,
                decoration: InputDecoration(
                  labelText: "Prix",
                  hintText: "Votre prix",
                  icon: Icon(Icons.price_change_rounded),
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Container(
              height: 50,
              child: DropdownButton(
                hint: Text("Select Categorie"),
                value: valCategorie,
                items: dataCategorie.map((item) {
                  return DropdownMenuItem(
                    value: item['id'],
                    //value: item['nom'].toString(),
                    child: Text(item['nom'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    valCategorie = value;
                    print("========= value id =========");
                    print(value);
                    print(valCategorie is int);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                  height: 50,
                  color: Colors.blue,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: (){
                      print('====in=====');
                        dbhelp.addProduit(
                          nomController.text.trim(),
                            prixController.text.trim(),
                            valCategorie
                        );
                        Navigator.pop(context);
                    },
                      child: Text(
                        "Ajouter Produit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
