import 'package:flutter/material.dart';
import 'package:inhalen/pages/instruction.dart';
import 'package:inhalen/services/colors.dart';


class BackAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.yellow,
        elevation: 0,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'KEMBALI',
          style: TextStyle(
              fontFamily: 'OpenSans', fontSize: 20, color: Colors.black),
        ),
        centerTitle: false,
      ),
    );
  }
}


class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yellow,
      appBar: BackAppbar(),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                width: 200,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/respiclick.png'),
                        fit: BoxFit.contain)),
              ),
              Container(
                height: 305,
                width: MediaQuery.of(context).size.width,
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25, left: 25),
                        child: Text(
                          'RespiClick',
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
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Instruction()));
                              },
                              color: CustomColors.maroon),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
