import 'package:app_flutter/querries.dart';
import 'package:app_flutter/results.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(child: PageInput()),
      ),
    );
  }
}

class PageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageRechercheState();

}

class PageRechercheState extends State<PageInput> {
  final venueController = TextEditingController();
  final locationController = TextEditingController();
  List<Results> resultats = new List<Results>();

  @override
  void dispose() {
    venueController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Widget equalNull(BuildContext cont, Object obj, String str) {
    if (obj != null) {
      return Text(str + " : " + obj);
    } else {
      return Text(str + " : " + "Inconnu");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            width: 100,
            height: 70,
            child: TextField(
              controller: locationController,
              decoration: InputDecoration(
                  labelText: 'Location', hintText: 'Location'),
            ),
          ),
          Container(
            width: 100,
            height: 70,
            child: TextField(
              controller: venueController,
              decoration: InputDecoration(
                  labelText: 'Venue', hintText: 'Venue'),
            ),
          ),
          Container(
            width: 100,
            height: 50,
            child: FlatButton(color:Colors.greenAccent,
                onPressed: () {

              fetchPost(locationController.text, venueController.text).then((result) {
                resultats.clear(); // Vide les anciens resultats
                setState(() {
                  resultats.addAll(result.listeResponses); // Ajoute les nouveaux résultats
                });
              });
            },
                child: Text("Rechercher")),
          )
        ]));
}


}
