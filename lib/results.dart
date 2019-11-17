class Results{
  String name;
  String desc;
  String id;
  List<String> photos = new List();
  List<String> comments = new List();
  String commentsBis;
  String latitude;
  String longitude;
  String city;
  String region;
  String country;
  String categories;

  Results(String id, String name){
    this.id= id;
    this.name= name;
  }

  Results.toString(){
    print("id : "+this.id + ", name : "+this.name);
  }

  setDescription(String desc){
    this.desc = desc;
  }
  setComments(List<String> comm){
    this.comments = comm;
  }
  setPhotos(List<String> ph){
    this.photos = ph;
  }
  setLatitude(String lat){
    this.latitude = lat;
  }
  setLongitude(String long){
    this.longitude = long;
  }

}
class Responses {
  final List<Results> listeResponses;

  Responses({this.listeResponses});

  factory Responses.fromJson(Map<String, dynamic> json) {
    List<Results> tes = new List<Results>();
    for (var items in json["response"]["venues"]) {
      Results itemReponse = new Results(items["id"], items["name"]);
      tes.add(itemReponse);

    }
    return Responses(listeResponses: tes);
  }
}