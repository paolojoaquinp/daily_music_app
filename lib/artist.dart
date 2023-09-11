import 'package:daily_music/utils/utils.dart';

final artists = List.generate(
  _artists.length,
  (index) {
    final _music = _artists[index]["musics"] as dynamic;

    final listMusic = List.generate(
        _music.length as int,
        (i) => Music(
            title: _music[i]["title"],
            mark: _music[i]["mark"],
            types: _music[i]["types"],
            tags: _music[i]["tags"],
            lyrics: getLyrics(),
            image: 'assets/${_artists[index]['title_img']}/${i+1}.jpeg'),
        );
    final el = _artists[index];
    return Artist(
      name: el["name"] as String,
      tags: el["tags"] as dynamic,
      musics: listMusic, 
    );
  }
);

class Artist {
  String name;
  List<String> tags;
  List<Music>? musics;

  Artist({
    required this.name,
    required this.tags,
    required this.musics,
  });
}

class Music {
  String title;
  double mark;
  List<String> types;
  List<String> tags;
  List<String> lyrics;
  String image;

  Music({
    required this.title,
    required this.mark,
    required this.types,
    required this.tags,
    required this.lyrics,
    required this.image,
  });
}

final _artists = [
  {
    "name": "Tim Bendzko",
    "title_img": "tim_bendzko",
    "tags": ["Clasical", "Popular", "Nationality"],
    "musics": [
      {
        "title": "Nur Noch Kurz Die Welt Retten",
        "mark": 5.0,
        "types": ["clasical", "Music poet"],
        "tags": ["VIP", "SQ"],
        "lyrics":
            "Woasmlaskdl alskdmfalskdfm laksmdflkamfdlasmklfdaksdmf lkasmdflasmdfklmasdfl alsdkmflaksmdfalksd aoirgjoigjeojr asdoafmisaodfkio asdoifaisdfkoi"
      },
      {
        "title": "Du Warst Noch Nie Hier",
        "mark": 4.0,
        "types": ["clasical", "Music poet"],
        "tags": ["SQ"],
        "lyrics":
            "Woasmlaskdl alskdmfalskdfm laksmdflkamfdlasmklfdaksdmf lkasmdflasmdfklmasdfl alsdkmflaksmdfalksd aoirgjoigjeojr asdoafmisaodfkio asdoifaisdfkoi"
      },
    ]
  },
  {
    "name": "Agnes Gibson",
    "title_img": "agnes_gibson",
    "tags": ["Clasical", "Popular", "Nationality"],
    "musics": [
      {
        "title": "Nur Noch Kurz Die Welt Retten",
        "mark": 5.0,
        "types": ["clasical", "Music poet"],
        "tags": ["VIP", "SQ"],
        "lyrics":
            "Woasmlaskdl alskdmfalskdfm laksmdflkamfdlasmklfdaksdmf lkasmdflasmdfklmasdfl alsdkmflaksmdfalksd aoirgjoigjeojr asdoafmisaodfkio asdoifaisdfkoi"
      }
    ]
  },
  {
    "name": "Harriet Gilbert",
    "title_img": "harriet_gilbert",
    "tags": ["Clasical", "Popular", "Nationality"],
    "musics": [
      {
        "title": "Nur Noch Kurz Die Welt Retten",
        "mark": 5.0,
        "types": ["clasical", "Music poet"],
        "tags": ["VIP", "SQ"],
        "lyrics":
            "Woasmlaskdl alskdmfalskdfm laksmdflkamfdlasmklfdaksdmf lkasmdflasmdfklmasdfl alsdkmflaksmdfalksd aoirgjoigjeojr asdoafmisaodfkio asdoifaisdfkoi"
      }
    ]
  },
  {
    "name": "Derek Fowler",
    "title_img": "derek_fowler",
    "tags": ["Clasical", "Popular", "Nationality"],
    "musics": [
      {
        "title": "Nur Noch Kurz Die Welt Retten",
        "mark": 5.0,
        "types": ["clasical", "Music poet"],
        "tags": ["VIP", "SQ"],
        "lyrics":
            "Woasmlaskdl alskdmfalskdfm laksmdflkamfdlasmklfdaksdmf lkasmdflasmdfklmasdfl alsdkmflaksmdfalksd aoirgjoigjeojr asdoafmisaodfkio asdoifaisdfkoi"
      },
    ]
  },
  {
    "name": "Duane Hubb",
    "title_img": "duane_hubb",
    "tags": ["Clasical", "Popular", "Nationality"],
    "musics": [
      {
        "title": "Nur Noch Kurz Die Welt Retten",
        "mark": 5.0,
        "types": ["clasical", "Music poet"],
        "tags": ["VIP", "SQ"],
        "lyrics":
            "Woasmlaskdl alskdmfalskdfm laksmdflkamfdlasmklfdaksdmf lkasmdflasmdfklmasdfl alsdkmflaksmdfalksd aoirgjoigjeojr asdoafmisaodfkio asdoifaisdfkoi"
      }
    ]
  },
  {
    "name": "Mathilda Obrien",
    "title_img": "mathilda_obrien",
    "tags": ["Clasical", "Popular", "Nationality"],
    "musics": [
      {
        "title": "Nur Noch Kurz Die Welt Retten",
        "mark": 5.0,
        "types": ["clasical", "Music poet"],
        "tags": ["VIP", "SQ"],
        "lyrics":
            "Woasmlaskdl alskdmfalskdfm laksmdflkamfdlasmklfdaksdmf lkasmdflasmdfklmasdfl alsdkmflaksmdfalksd aoirgjoigjeojr asdoafmisaodfkio asdoifaisdfkoi"
      }
    ]
  },
];
