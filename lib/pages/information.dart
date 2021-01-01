import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:inhalen/pages/video_page.dart';
import 'package:inhalen/services/colors.dart';

class BackAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.yellow,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0),
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.black,
        iconSize: 36,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          'back_button',
          style: Theme.of(context).textTheme.headline5,
        ).tr(),
      ),
      centerTitle: false,
    );
  }
}

class Information extends StatelessWidget {
  final Map inhalerInfo;
  final int index;

  Information({Key key, @required this.inhalerInfo, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yellow,
      appBar: BackAppbar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'yellow_container$index',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 250,
                  width: 250,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/${inhalerInfo['name']}.png'),
                          fit: BoxFit.contain)),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 1),
                    )
                  ]),
              child: BottomCard(inhalerInfo: inhalerInfo),
            )
          ],
        ),
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key key,
    @required this.inhalerInfo,
  }) : super(key: key);

  final Map inhalerInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25, left: 20),
            child: Text(inhalerInfo['name'],
                style: Theme.of(context).textTheme.headline4),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            width: double.infinity,
            child: Text(
              inhalerInfo['description'],
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: 350,
              height: 50,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'how_to_use_button',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Open Sans',
                      color: Colors.white,
                    ),
                  ).tr(),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VideoPage(videoId: inhalerInfo['video_id'])));
                  },
                  color: CustomColors.maroon),
            ),
          )
        ]);
  }
}
