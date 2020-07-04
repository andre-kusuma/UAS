import 'package:flutter/material.dart';
//import terlebih dahulu halaman yang diperlukan
import './detailproduk.dart';

class ProdukList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appbar
        appBar: AppBar(title: Text("List Product")),
        //body untuk content
        //menampilkan list
        body: ListView(
          shrinkWrap: true,
          //padding
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          //anggota dari list berupa widget children
          children: <Widget>[
            //GestureDetector untuk menangani gesture pengguna
            new GestureDetector(
              //listener  berupa klik 1x
              onTap: () {
                //navigator.push  untuk berpindah halaman
                Navigator.of(context).push(new MaterialPageRoute(
                  //pemanggilan class DetailProduk beserta pengiriman detail produk
                  builder: (BuildContext context) => DetailProduk(
                    name: "Kucing Sphynx",
                    description: "Sphynx merupakan kucing hasil rekayasa genetika asal Kanada dan merupakan jenis keturunan dari kucing tanpa bulu. Jika dilihat sepintas maka tubuh Sphynx akan terlihat botak, namun jika diperhatikan dengan seksama maka kucing yang diadopsi dari nama patung di Mesir ini memiliki bulu yang sangat pendek dan sangat sedikit sekali, yang terdapat pada bagian ekor, kaki, telinga, dan dekat organ kelamin.",
                    price: 5000000,
                    image: "Sphynx.jpg",
                    star: 3,
                  ),
                ));
              },
              //memanggil class Productbox
              child: ProductBox(
                  //berisi parameter yang diperlukan di class ProductBox
                  name: "Kucing Sphynx",
                  description: "Klik Untuk Detail",
                  price: 5000000,
                  image: "Sphynx.jpg",
                  star: 3),
            ),
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => DetailProduk(
                      name: "Kucing Sabana",
                      description: "Sabana atau Savannah merupakan jenis kucing hasil hibrida dari ras kucing Serval Afrika dengan kucing Bengal, Siam, dan Mau Mesir. Kucing asal Amerika Serikat ini merupakan jenis kucing terpajang di dunia dengan ukuran tubuh yang bisa mencapai 44 cm. Tampilan kucing Sabana terlihat seperti kucing liar yang buas, namun sejatinya ia merupakan kucing yang cerdas, ramah, setia, dan mudah bersosialisasi.",
                      price: 7000000,
                      image: "Kucing-Sabana.jpg",
                      star: 4,
                    ),
                  ));
                },
                child: ProductBox(
                    name: "Kucing Sabana",
                    description: "Klik Untuk Detail",
                    price: 7000000,
                    image: "Kucing-Sabana.jpg",
                    star: 4)),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => DetailProduk(
                    name: "Kucing Siam",
                    description: "Kucing berjenis oriental pertama ini banyak ditemukan di negara Siam (Thailand). Ras murni yang memiliki bulu pendek dengan tanda pada kaki, ekor dan wajahnya ini merupakan kucing terpopuler di dunia. Ia memiliki mata berwarna biru dengan tubuh ramping dan kaki serta ekor yang panjang. Siam juga memiliki bentuk wajah yang menyerupai apel, segitiga, dan baji sehingga unik dan mudah dikenali.",
                    price: 5000000,
                    image: "Kucing-Siam.jpg",
                    star: 5,
                  ),
                ));
              },
              child: ProductBox(
                  name: "Kucing Siam",
                  description: "Klik Untuk Detail",
                  price: 5000000,
                  image: "Kucing-Siam.jpg",
                  star: 5),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => DetailProduk(
                    name: "Kucing Britania",
                    description: "Kucing bulu pendek Britania merupakan ras tertua yang diyakini ada hubungannya dengan bangsa Romawi yang pernah menjajah Britania. Ras ini memiliki tubuh gempal dengan bulu pendek berwarna abu-abu kebiruan, namun kemudian dikawinkan silang dengan jenis Persia agar tidak punah dan menghasilkan kucing bulu pendek dengan berbagai warna. Kucing ini juga banyak menjadi ikon film animasi atau produk makanan kucing “Whiskas”.",
                    price: 1500000,
                    image: "Kucing-Bulu-Pendek-Britania.jpg",
                    star: 4,
                  ),
                ));
              },
              child: ProductBox(
                  name: "Kucing Britania",
                  description:
                      "Klik Untuk Detail",
                  price: 1500000,
                  image: "Kucing-Bulu-Pendek-Britania.jpg",
                  star: 4),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => DetailProduk(
                    name: "Kucing Chartreux",
                    description: "Chartreux merupakan kucing domestik asal Perancis yang perawakannya mirip dengan kucing bulu pendek Britania. Kucing ini berbadan besar dengan diselimuti bulu pendek lapis ganda berwarna abu-abu kebiruan. Chartreux merupakan pemburu yang hebat, namun ia tidak agresif dan sangat baik terhadap anak-anak.",
                    price: 2000000,
                    image: "Chartreux.jpg",
                    star: 5,
                  ),
                ));
              },
              child: ProductBox(
                name: "Kucing Chartreux",
                description: "Klik Untuk Detail",
                price: 2000000,
                image: "Chartreux.jpg",
                star: 5,
              ),
            ),
          ],
        ));
  }
}

//menggunakan widget StatelessWidget
class ProductBox extends StatelessWidget {
  //deklarasi variabel yang diterima dari MyHomePage
  ProductBox(
      {Key key, this.name, this.description, this.price, this.image, this.star})
      : super(key: key);
  //menampung variabel yang diterima untuk dapat digunakan pada class ini
  final String name;
  final String description;
  final int price;
  final String image;
  final int star;
  final children = <Widget>[];

  Widget build(BuildContext context) {
    for (var i = 0; i < star; i++) {
      children.add(new Icon(
        Icons.star,
        size: 10,
        color: Colors.deepOrange,
      ));
    }
    //menggunakan widget container
    return Container(
        //padding
        padding: EdgeInsets.all(10),
        // height: 120,
        //menggunakan widget card
        child: Card(
            //membuat tampilan secara horisontal antar image dan deskripsi
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //children digunakan untuk menampung banyak widget
                children: <Widget>[
              Image.asset(
                "assets/appimages/" + image,
                width: 150,
              ),
              Expanded(
                  //child digunakan untuk menampung satu widget
                  child: Container(
                      padding: EdgeInsets.all(5),
                      //membuat tampilan secara vertikal
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //ini isi tampilan vertikal tersebut
                        children: <Widget>[
                          //menampilkan variabel menggunakan widget text
                          Text(this.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(this.description),
                          Text(
                            "Price: " + this.price.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                          //menampilkan widget icon  dibungkus dengan row
                          Row(
                            children: <Widget>[
                              Row(
                                children: children,
                              )
                            ],
                          )
                        ],
                      )))
            ])));
  }
}
