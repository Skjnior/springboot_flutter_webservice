import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AddProduit_page.dart';
import 'DetailsProduits_page.dart';

class ListeProduis extends StatefulWidget {
  const ListeProduis({super.key});

  @override
  State<ListeProduis> createState() => _ListeProduisState();
}

class _ListeProduisState extends State<ListeProduis> {
  //late List data;
  //var data ;
  var data = [];
  Future<List<dynamic>> getData() async {
    var url = Uri.parse("http://192.168.1.172:4200/api/listeProduitsApi");
    final response = await http.get(url);

    //var url = "192.168.17.146:3900";
    //final response = await http.get(Uri.http(url),"api/listeProduitsApi");

    print("${response.statusCode}");
    print("${response.body}");
    return json.decode(response.body);
  }

  _navigateAddProduit(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddProduitPage()));

    if (result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des produits"),
        actions: [
          ElevatedButton(
            onPressed: () => _navigateAddProduit(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            final datas = snapshot.data as dynamic;
            return Center(child: ItemList(list: datas));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<dynamic> list;
  const ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context)=>DetailsProduit(
                    list:list,
                   index:i
                  )
                  )),
                  child: Container(
                    height: 100.3,
                    child: Card(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  list[i]['nom'].toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black87,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  list[i]['prix'].toString(),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                  ),
                                )),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
