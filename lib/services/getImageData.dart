import 'package:cloud_firestore/cloud_firestore.dart';
Future getImageList()async{
  List imageList=List();
await Firestore.instance
    .collection('users')
.getDocuments()
    .then((QuerySnapshot querySnapshot) => {
querySnapshot.documents.forEach((doc) {
imageList.add(doc.data["imageLinks"][0]);
})
}).whenComplete(() {
});
  return imageList;
}