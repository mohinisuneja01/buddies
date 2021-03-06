import 'package:buddies/services/currentUser.dart';
import 'package:buddies/services/uploadFile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buddies/tinderui/scr/draggable_card.dart';
import 'package:buddies/tinderui/scr/matches.dart';
import 'package:buddies/tinderui/scr/photo_browser.dart';
import 'package:buddies/tinderui/scr/profiles.dart';
import 'package:buddies/tinderui/utils/images.dart';
class ProfileCard extends StatefulWidget {
  final Profile profile;
  final Decision decision;
  final SlideRegion region;
  final bool isDraggable;
  final imageList;
   const ProfileCard({
    Key key,
    this.profile,
    this.decision,
    this.region,
    this.isDraggable = true,
    this.imageList
  }) : super(key: key);
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  CollectionReference firedb,firedb2;
  FirebaseUser user;
  Widget _buildPhotos() {
    return new PhotoBrowser(
        photoAssetPaths: widget.profile.photos,visiblePhotoIndex: 0,);
  }

  Widget _buildProfileSynopsis() {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Expanded(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
         //       "${firedb2.snapshots().elementAt(0)}",
        //document('${user.email}').get()}, ${widget.profile.age}",
            widget.profile.name.split(" ")[0]
           , style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold),
              ),
              new Text(
                widget.profile.bio,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w400),
              ),
              new Text(
                widget.profile.college,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w400),
              ),
            ],
          )),

        ],
      ),
    );
  }

  @override
  void initState() {
    //_auth=FirebaseAuth.instance;
    assignUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    firedb2=Firestore.instance.collection('users');

//    print('build card card');
//    print(widget.imageList);

    return Scaffold(
      backgroundColor: Colors.white70,
      body: Material(
        borderRadius: BorderRadius.circular(20.0),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0),
//                        boxShadow: [
//                  new BoxShadow(
//                      color: Colors.black.withAlpha(50),
//                      blurRadius: 5.0,
//                      spreadRadius: 2.0)]
                     ),
                child: new ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: new Material(
                    borderRadius: BorderRadius.circular(20),
                    child: new Stack(
//                fit: StackFit.expand,
                      children: <Widget>[
                        _buildPhotos(),
                        widget.isDraggable == false
                            ? new Container(
                                color: Colors.transparent,
                              )
                            : _buildRegionIndicator(),
                        widget.isDraggable == false
                            ? new Container(
                                color: Colors.transparent,
                              )
                            : _buildDecisionIndicator()
                      ],
                    ),
                  ),
                ),
              ),    _buildProfileSynopsis(),
            ],
          ),
        ),
      ),
    );
  }


  Future<Widget> _getImage(BuildContext context, List image) async {
    Image m;
//    await FireStorageService.loadImage(context, image).then((downloadUrl) {
//      m = Image.network(
//        downloadUrl.toString(),
//        fit: BoxFit.scaleDown,
//      );
//    });
    return m;
  }


  Widget _buildRegionIndicator() {
    switch (widget.region) {
      case SlideRegion.inNopeRegion:
        return _nopeIndicator();
        break;
      case SlideRegion.inLikeRegion:
        return _likeIndicator();
        break;
      case SlideRegion.inSuperLikeRegion:
        return _superLikeIndicator();
        break;
      default:
        return new Container(
          color: Colors.transparent,
        );
    }
  }

  Widget _buildDecisionIndicator() {
    switch (widget.decision) {
      case Decision.nope:
        return _nopeIndicator();
        break;
      case Decision.like:
        return _likeIndicator();
        break;
      case Decision.superLike:
        return _superLikeIndicator();
        break;
      default:
        return new Container(
          color: Colors.transparent,
        );
    }
  }

  Widget _nopeIndicator() {
    return new Align(
      alignment: Alignment.topRight,
      child: new Transform.rotate(
        angle: 270.0,
        origin: Offset(0.0, 0.0),
        child: new Container(
          height: 80.0,
          width: 150.0,
          margin: const EdgeInsets.all(16.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.red, width: 5.0)),
          child: Center(
              child: new Text(
            "NOPE",
            style: TextStyle(
                color: Colors.red, fontSize: 40.0, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  Widget _likeIndicator() {
    return new Align(
      alignment: Alignment.topLeft,
      child: new Transform.rotate(
        angle: 270.0,
        origin: Offset(0.0, 0.0),
        child: new Container(
          height: 80.0,
          width: 150.0,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 5.0)),
          child: Center(
              child: new Text(
            "LIKE",
            style: TextStyle(
                color: Colors.green,
                fontSize: 40.0,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  Widget _superLikeIndicator() {
    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Container(
        height: 150.0,
        width: 150.0,
        margin: const EdgeInsets.only(bottom: 100.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.blue, width: 5.0)),
        child: Center(
            child: new Text(
          "SUPER LIKE",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue, fontSize: 40.0, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
  assignUser() async {
    user=await getUser();
  }

}
