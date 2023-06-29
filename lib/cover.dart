class Cover {
  final String name;
  final String img;
  final String vinyl;
  final String country;
  final String description;
  final String label;
  final String genre;

  final double price;

  Cover({
    required this.price,
    required this.name,
    required this.img,
    required this.vinyl,
    required this.country,
    required this.description,
    required this.label,
    required this.genre,
  });
}

List<Cover> covers = [
  Cover(
      name: "Florence + the machine",
      img: "asset/1.png",
      price: 32.3,
      genre: "Pop - Rock",
      country: "Royaume-Uni",
      label: "Moshi",
      description:
          "Florence and the Machine, également stylisé Florence + the Machine, est un groupe de rock indépendant britannique, originaire de Londres, en Angleterre.",
      vinyl: "asset/disque.png"),
  Cover(
    name: "Onuka",
    img: "asset/2.png",
    price: 93.1,
    vinyl: "asset/disque.png",
    genre: "Experimental - electronic",
    label: "Vidlik",
    country: "Ukraine",
    description:
        "ONUKA (literally: granddaughter) is a Ukrainian electro-folk band. It was created in 2013 by Ukrainian musicians Yevhen Filatov and Nata Zhyzhchenko",
  ),
  Cover(
    name: "Space Ocenaika",
    img: "asset/3.png",
    price: 45.7,
    vinyl: "asset/disque.png",
    genre: "Pop",
    country: "Usa",
    label: "JioSaavn",
    description:
        "Space Lyrics by ocenaika. Now, listen to all your favourite songs, along with the lyrics, only on JioSaavn.",
  ),
  Cover(
    name: "The velvet underground & nico",
    img: "asset/4.jpeg",
    price: 23.9,
    vinyl: "asset/disque.png",
    country: "Usa",
    label: "Verve Records",
    genre: "Rock - Art rock",
    description:
        "The Velvet Underground & Nico est le premier album du groupe de rock américain The Velvet Underground, accompagné par la chanteuse Nico et produit par l'artiste Andy Warhol",
  ),
];
