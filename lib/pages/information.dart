import 'package:flutter/material.dart';
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
          'KEMBALI',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 24,
              color: Colors.black,
              letterSpacing: 1.5),
        ),
      ),
      centerTitle: false,
    );
  }
}

class Information extends StatelessWidget {
  final Map inhalerInfo;

  Information({Key key, @required this.inhalerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yellow,
      appBar: BackAppbar(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                width: 200,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/${inhalerInfo['name']}.png'),
                        fit: BoxFit.contain)),
              ),
              Container(
                height: 305,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25, left: 25),
            child: Text(
              inhalerInfo['name'],
              style: TextStyle(
                  fontFamily: 'Raleway',
                  color: CustomColors.maroon,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 25),
            height: 100,
            width: 360,
            child: Text(
              inhalerInfo['description'],
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: 350,
              height: 50,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'CARA PEMAKAIAN',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Open Sans',
                      color: Colors.white,
                    ),
                  ),
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
