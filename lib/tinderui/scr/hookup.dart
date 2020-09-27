import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buddies/tinderui/scr/card_stack.dart';
import 'package:buddies/tinderui/scr/draggable_card.dart';
import 'package:buddies/tinderui/scr/matches.dart';
import 'package:buddies/tinderui/scr/profile_card.dart';
import 'package:buddies/tinderui/scr/profiles.dart';
import 'package:buddies/tinderui/utils/images.dart';
import 'round_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final MatchEngine matchEngine = new MatchEngine(
  matches: demoProfile.map((Profile profile) {
    return new DateMatch(profile: profile);
  }).toList(),
);

class HookUp extends StatefulWidget {
  @override
  _HookUpState createState() => _HookUpState();
}

class _HookUpState extends State<HookUp>
    with AutomaticKeepAliveClientMixin<HookUp> {
  Stream<QuerySnapshot> db;
  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new RoundIconButton.small(
              icon: Icons.settings_backup_restore,
              iconColor: Colors.orange,
              onPressed: () {},
            ),
            new RoundIconButton.large(
              icon: Icons.clear,
              iconColor: Colors.red,
              onPressed: () {
                matchEngine.currentMatch.nope();
              },
            ),
            new RoundIconButton.small(
              icon: Icons.star,
              iconColor: Colors.blue,
              onPressed: () {
                matchEngine.currentMatch.superLike();
              },
            ),
            new RoundIconButton.large(
              icon: Icons.favorite,
              iconColor: Colors.green,
              onPressed: () {
                matchEngine.currentMatch.like();
              },
            ),
            new RoundIconButton.widget(
              imageAsset: lightening,
              iconColor: Colors.purple,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print((demoProfile?.elementAt(2)?.email)??0);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: new CardStack(matchEngine: matchEngine)),
    StreamBuilder(
    stream: db,
    builder: (context,snapshot){
//      print('start1'+'  '+'${snapshot.data.documents.length}');
      if(snapshot.hasData)
    return Container(
      height: 0,
      child: ListView.builder(itemCount:snapshot.data.documents.length,
      itemBuilder: (context,int index){
        print('start2');
      var ds = snapshot.data.documents[index].data;
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
      return SizedBox(height:0,);
      }),
    );
    return SizedBox(height: 0,);
    },

    )

        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
@override
  void initState() {
  db=Firestore.instance.collection('users').snapshots();
  super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
