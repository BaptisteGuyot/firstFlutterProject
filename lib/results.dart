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

class ReponsesDetails {
  Results itemReponse;

  ReponsesDetails({this.itemReponse});

  factory ReponsesDetails.fromJson(Map<String, dynamic> json) {
    Results itemR = new Results(json["response"]["venue"]["id"], json["response"]["venue"]["name"]);
    itemR.setLatitude(json["response"]["venue"]["location"]["lat"].toString());
    itemR.setLongitude(json["response"]["venue"]["location"]["lng"].toString());
    if(json["response"]["venue"]["description"] != null){
      itemR.setDescription(json["response"]["venue"]["description"]);
    }else{
      itemR.desc = null;
    }
    if(json["response"]["venue"]["tips"]["groups"][0]["items"].toString().length > 2){
      itemR.commentsBis = (json["response"]["venue"]["tips"]["groups"][0]["items"][0]["text"]);
    } else {
      itemR.commentsBis = null;
    }
    if(json["response"]["venue"]["bestPhoto"] != null){
      itemR.photos.add(
          json["response"]["venue"]["bestPhoto"]["prefix"]+
              json["response"]["venue"]["bestPhoto"]["width"].toString()+
              "x"+
              json["response"]["venue"]["bestPhoto"]["height"].toString()+
              json["response"]["venue"]["bestPhoto"]["suffix"]

      );
    }else{
      itemR.photos.add(
          "https://www.prendsmaplace.fr/wp-content/themes/prendsmaplace/images/defaut_image.gif"
      );
    }
    if(json["response"]["venue"]["categories"].toString().length > 2) {
      itemR.categories = json["response"]["venue"]["categories"][0]["name"];
    }else{
      itemR.categories = null;
    }

    return ReponsesDetails(itemReponse: itemR);
  }
}
