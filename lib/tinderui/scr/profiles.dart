import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buddies/tinderui/utils/images.dart';
import 'package:flutter/cupertino.dart';

final List<Profile> demoProfile =

[

  Profile(
    name: 'Mohini',
    college: 'Satyug Darshan Technical Campus',
    bio: 'Flutter Developer',
    email: 'mohinisuneja24@gmail.com',
    photos: ['https://i.picsum.photos/id/1011/5472/3648.jpg?hmac=Koo9845x2akkVzVFX3xxAc9BCkeGYA9VRVfLE4f0Zzk']
  ),
  Profile(
      name: 'Amit',
      college: 'NSUT West Campus',
      bio: 'Flutter Developer',
      email: 'amitsuneja24@gmail.com',
      photos: ['https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY']
  )
//  new Profile(
//      photos: [img1, img2, img3, img4],
//      name: "Maugost Mtellect",
//      bio: "Who wants to swim?",
//      location: "Delta State",
//      age: 25),
//  new Profile(
//      photos: [img4, img3, img2, img1],
//      name: "John Ebere",
//      bio: "What's life with out fun?",
//      location: "Kombe State",
//      age: 22),
//  new Profile(
//      photos: [img2, img3, img4, img1],
//      name: "Jennifer Styles",
//      bio: "just here to catch fun!",
//      location: "Lagos State.",
//      age: 23),
//  new Profile(
//      photos: [img3, img1, img2, img4],
//      name: "Ann Jose",
//      bio: "Let's hang out!",
//      location: "Abia State.",
//      age: 20),
//  new Profile(
//      photos: [img1, img4, img3, img2],
//      name: "Jame Agwu",
//      bio: "catching fun is my hobby!",
//      location: "Rivers State.",
//      age: 28)
];

class Profile {
  final List photos;
  final String name;
  final String college;
  final String bio;
  final String email;
  Profile({this.photos, this.name, this.college, this.bio, this.email});

}
Future getUserData()async{
  var db=Firestore.instance.collection('users').snapshots();
  StreamBuilder(
    stream: db,
    builder: (context,snapshot){
      print('start');
     ListView.builder(itemCount:snapshot.data.documents.length,
         itemBuilder: (context,int index){
           DocumentSnapshot ds = snapshot.data.documents[index].data;
       demoProfile.add(
         Profile(
           name:ds['Name'],
           college: ds['institution'],
           bio: ds['about'],
           photos: ds['imageLinks'],
           email: ds['email']
         )
       );
       print("added");
       return;  });
    return;
      },

  );
//  List imageList=List();
//  await Firestore.instance
//      .collection('users')
//      .getDocuments()
//      .then((QuerySnapshot querySnapshot) => {
//    querySnapshot.documents.forEach((doc) {
//      imageList.add(doc.data["imageLinks"][0]);
//    })
//  }).whenComplete(() {
//  });
//  return imageList;
}