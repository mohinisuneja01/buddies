import 'package:flutter/material.dart';
import 'package:buddies/services/getImageData.dart';
import 'package:buddies/tinderui/scr/selected_photo_indicator.dart';

class PhotoBrowser extends StatefulWidget {
  final List photoAssetPaths;
  final int visiblePhotoIndex;

  const PhotoBrowser({this.photoAssetPaths, this.visiblePhotoIndex});
  @override
  _PhotoBrowserState createState() => _PhotoBrowserState();
}

class _PhotoBrowserState extends State<PhotoBrowser> {
  int visiblePhotoIndex;
List imageLinks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    visiblePhotoIndex = widget.visiblePhotoIndex;
  }

  @override
  void didUpdateWidget(PhotoBrowser oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.visiblePhotoIndex != oldWidget.visiblePhotoIndex) {
      if(this.mounted)
      setState(() {
        visiblePhotoIndex = widget.visiblePhotoIndex;
      });
    }
  }

  void _previousImage() {
    if(this.mounted)
    setState(() {
      print("called");
      visiblePhotoIndex = visiblePhotoIndex > 0 ? visiblePhotoIndex - 1 : 0;
//    visiblePhotoIndex=1;
    });
  }
  void _nextImage() {
    if(this.mounted)
    setState(() {
      print("called");
//      visiblePhotoIndex=1;
      visiblePhotoIndex = visiblePhotoIndex < widget.photoAssetPaths.length - 1
          ? visiblePhotoIndex + 1
          : visiblePhotoIndex;
    });
  }

  Widget _buildPhotoControls() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
//        new GestureDetector(
//          onTap: _previousImage,
//          child: new FractionallySizedBox(
//            widthFactor: 0.5,
//            heightFactor: 1.0,
//            alignment: Alignment.topLeft,
//            child: Container(
//              color: Colors.transparent,
//            ),
//          ),
//        ),
//        new GestureDetector(
//          onTap: _nextImage,
//          child: new FractionallySizedBox(
//            widthFactor: 0.5,
//            heightFactor: 1.0,
//            alignment: Alignment.topRight,
//            child: Container(
//              color: Colors.transparent,
//            ),
//          ),
//        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(visiblePhotoIndex);
//    print('last');
//    print(imageLinks);
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        //photo
        Image.network(
          widget.photoAssetPaths[visiblePhotoIndex],
          fit: BoxFit.cover,
        ),           //photo indicator
//        new Positioned(
//            top: 0.0,
//            right: 0.0,
//            left: 0.0,
//            child: new SelectedPhotoIndicator(
//                photoCount:,
//                visiblePhotoIndex: visiblePhotoIndex))

//        photo controls

      ],
    );
  }
assignImageList()async{
//  print('image lInks');
    await getImageList().then((value)
    {if(this.mounted)
      setState(() {
      imageLinks=value;

    });

    }
    );
//  print(imageLinks);
}
}
