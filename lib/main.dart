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
        body: Center(child: PageRecherche()),
      ),
    );
  }
}

class PageRecherche extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageRechercheState();
}

class PageRechercheState extends State<PageRecherche> {
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
  Widget _MySecondPageStatsse(BuildContext context, Results item) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              item.name ?? 'Aucun Titre',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            equalNull(context, item.categories, "Categorie"),
            Text(item.desc ?? 'Description : Non référencée !'),
            Image.network(item.photos[0]),
            Text(
              'Commentaire :',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(item.commentsBis ?? 'Aucune Commentaires !'),
            InkWell(
                child: new Text(
                  'Show on the Map',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => {print("cc")}),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Row(
                children :  [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: 70,
                  child: TextField(
                    controller: locationController,
                    decoration:
                    InputDecoration(labelText: 'Location', hintText: 'Location'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: 70,
                  child: TextField(
                    controller: venueController,
                    decoration: InputDecoration(labelText: 'Venue', hintText: 'Venue'),
                  ),
                ),
                ]),

      Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: FlatButton(
            color: Colors.lightBlue,
            onPressed: () {
              fetchPost(locationController.text, venueController.text)
                  .then((result) {
                resultats.clear(); // Vide les anciens resultats
                setState(() {
                  resultats.addAll(
                      result.listeResponses); // Ajoute les nouveaux résultats
                });
              });
            },
            child: Text("Rechercher")),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: resultats.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(5.0),
                    color: Colors.amber[500],
                    child: Center(child: Text(resultats[index].name)),
                  ),
                  onTap: () => {
                        getVenueDetails(resultats[index]).then((result) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => _MySecondPageStatsse(
                                      context, result.itemReponse)));
                        }),
                      });
            }),
      ),
    ])));
  }
}
