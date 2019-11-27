import 'package:app_flutter/querries.dart';
import 'package:app_flutter/results.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  // ignore: non_constant_identifier_names
  Widget _PageDetailsState(BuildContext context, Results item) {
    return Scaffold(
      body: Center(
        child: Container(
          margin:EdgeInsets.only(top:100.0),
          child: Column(
            children: <Widget>[
              Text(
                item.name ?? 'Aucun Titre',
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              equalNull(context, item.categories, "Categorie"),
              Text(item.desc ?? 'Description : Non référencée !'),

              CarouselSlider(
                height: 400.0,
                items: item.photos.map((i) {
                  return Image.network(i);
                }).toList(),
              ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
      Row(children: [
        Container(
          // INPUT LOCATION
          width: MediaQuery.of(context).size.width / 2,
          height: 70,
          child: TextField(
            controller: locationController,
            decoration:
                InputDecoration(labelText: 'Location', hintText: 'Location'),
          ),
        ),
        Container(
          // INPUT VENUE
          width: MediaQuery.of(context).size.width / 2,
          height: 70,
          child: TextField(
            controller: venueController,
            decoration: InputDecoration(labelText: 'Venue', hintText: 'Venue'),
          ),
        ),
      ]),
      Container(
        // BOUTON RECHERCHER
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: EdgeInsets.only(bottom: 50.0),
        // Marge pour séparer les champs et les résultats
        child: FlatButton(
            color: Colors.lightBlue,
            onPressed: () {
              fetchPost(locationController.text, venueController.text, context)
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
        // RESULTATS
        child: ListView.builder(
            itemCount: resultats.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  child: Container(
                    height: 50,
                    decoration: myBoxDecoration(),
                    // https://medium.com/@suragch/adding-a-border-to-a-widget-in-flutter-d387bc5d7cff
                    margin: EdgeInsets.all(3.0),
                    child: Center(child: Text(resultats[index].name)),
                  ),
                  onTap: () => {
                        getVenueDetails(resultats[index], context).then((result) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => _PageDetailsState(
                                      context, result.itemReponse)));
                        }),
                      });
            }),
      ),
    ])));
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}
