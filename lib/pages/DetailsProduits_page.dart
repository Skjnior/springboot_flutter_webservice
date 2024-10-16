
import 'package:flutter/material.dart';

import '../controllers/DatabaseHelpers.dart';
import 'EditProduit_page.dart';
import 'Liste_produits.dart';

class DetailsProduit extends StatefulWidget {
  late List<dynamic> list;
  late int index;
   DetailsProduit({required this.list,required this.index});

  @override
  State<DetailsProduit> createState() => _DetailsProduitState();
}

class _DetailsProduitState extends State<DetailsProduit> {

  DataBaseHelper dbhelp = DataBaseHelper();
  _navigateListeProduit(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListeProduis()));

    if (result) {
      setState(() {});
    }
  }
void confirm(){
  AlertDialog alertDialog = AlertDialog(
        title:  Text('Confirmation'),
        content:  Text("Voulez-vous supprimer: ${widget.list[widget.index]['id']}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              dbhelp.suprimerProduit(widget.list[widget.index]['id'].toString());
              _navigateListeProduit(context);
            },
            child: const Text('OK Supprimer'),
          ),
        ],
      );
  //showDialog(context: context, child: alertDialog);
  child: const Text('Show Dialog');
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 350,
        padding: EdgeInsets.all(20),
        child: Card(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(widget.list[widget.index]['nom'],
                    style: TextStyle(fontSize: 20),),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(widget.list[widget.index]['prix'].toString(),
                      style: TextStyle(fontSize: 30),),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(widget.list[widget.index]['categorie']['nom'],
                      style: TextStyle(fontSize: 20),),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(

                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProduitPage(
                              list:widget.list,
                              index: widget.index
                          )));
                        },
                        child: Text("Modifier",style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          confirm();
                        },
                        child: Text("Supprimer",style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),

                      ),
                    ],
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }
}
