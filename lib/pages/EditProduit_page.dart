
import 'package:flutter/material.dart';

import '../controllers/DatabaseHelpers.dart';
import 'Liste_produits.dart';
class EditProduitPage extends StatefulWidget {
  final List<dynamic> list;
  final int index;
  const EditProduitPage({required this.list,required this.index});

  @override
  State<EditProduitPage> createState() => _EditProduitPageState();
}

class _EditProduitPageState extends State<EditProduitPage> {

  DataBaseHelper dbhelp = DataBaseHelper();
   late TextEditingController idController ;
  late  TextEditingController nomController ;
  late TextEditingController prixController ;


  _navigateListeProduit(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListeProduis()));

    if (result) {
      setState(() {});
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    idController = TextEditingController(
      text: widget.list[widget.index]['id'].toString()
    );
    nomController = TextEditingController(
        text: widget.list[widget.index]['nom'].toString()
    );
    prixController = TextEditingController(
        text: widget.list[widget.index]['prix'].toString()
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Column(
            children: [
              ListTile(
                  leading:  Icon(Icons.key),
                  title: TextFormField(
                    controller: idController,
                    decoration: InputDecoration(
                        labelText: "ID",
                        hintText: "Votre ID",
                        border: OutlineInputBorder()
                    ),
                  )
              ),
              ListTile(
                  leading:  Icon(Icons.person_pin_rounded),
                  title: TextFormField(
                    controller: nomController,
                    validator: (value){
                      if(value!.isEmpty) return "nom";
                    },
                    decoration: InputDecoration(
                        labelText: "Nom",
                        hintText: "Votre nom",
                        border: OutlineInputBorder()
                    ),
                  )
              ),
              ListTile(
                  leading:  Icon(Icons.price_change_rounded),
                  title: TextFormField(
                    controller: prixController,
                    decoration: InputDecoration(
                        labelText: "Prix",
                        hintText: "Votre prix",
                        border: OutlineInputBorder()
                    ),
                  )
              ),
              Divider(height: 2,),
              Padding(
                  padding: EdgeInsets.all(10)
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellowAccent),
                onPressed: (){
                  dbhelp.editerProduit(
                    idController.text.trim(),
                      nomController.text.trim(),
                      prixController.text.trim()
                  );
                  _navigateListeProduit(context);

                },
                child: Text(
                  "Modifier Produit",
                  style: TextStyle(
                    color: Colors.white,

                  ),
                ),

              ),
      
            ],
          )
        ],
      ),
    );
  }
}
