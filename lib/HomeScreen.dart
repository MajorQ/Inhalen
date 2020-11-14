import 'package:flutter/material.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Halo, Salman',
                style: TextStyle(
                  fontFamily: "Raleway",
                  color: Color.fromRGBO(139, 38, 53, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 39,
                )),
            SizedBox(
              height: 12,
            ),
            Text(
              'Ayo kita pelajari penggunaan Inhaler!',
              style: TextStyle(
                  fontFamily: "Raleway", color: Colors.black, fontSize: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              margin: EdgeInsets.only(top: 25, right: 23),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 1),
                    )
                  ]),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Pencarian",
                    border: InputBorder.none),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 25),
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  
                  SizedBox(
                    width: 5,
                  ),

                  //Baris Pertama

                  //inhaler pertama
                  Container(
                    margin: EdgeInsets.only(top: 2, right: 16, bottom: 2),
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 245, 174, 1),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/respiclick.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 160,
                            height: 48,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Nama Inhaler',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Raleway"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Inhaler Kedua
                  Container(
                    margin: EdgeInsets.only(top: 2, right: 16, bottom: 2),
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 245, 174, 1),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/respiclick.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 160,
                            height: 48,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Nama Inhaler',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Raleway"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Inhaler Ketiga
                  Container(
                    margin: EdgeInsets.only(top: 2, right: 16, bottom: 2),
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 245, 174, 1),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/respiclick.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 160,
                            height: 48,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Nama Inhaler',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Raleway"),
                            ),
                          ),
                        )
                      ],
                    ),
                    

                  ),
                ],
              ),

            ),
            //END OF INHALER ATAS


            //Inhaler Bawah

            Container(
              height: 200,
              margin: EdgeInsets.only(top: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),

                  //inhaler pertama
                  Container(
                    margin: EdgeInsets.only(top: 2, right: 16, bottom: 2),
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 245, 174, 1),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/respiclick.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 160,
                            height: 48,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Nama Inhaler',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Raleway"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //END OF INHALER PERTAMA

                  //inhaler Kedua
                  Container(
                    margin: EdgeInsets.only(top: 2, right: 16, bottom: 2),
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 245, 174, 1),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/respiclick.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 160,
                            height: 48,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Nama Inhaler',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Raleway"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //END OF INHALER KEDUA

                  //Inhaler Ketiga
                  Container(
                    margin: EdgeInsets.only(top: 2, right: 16, bottom: 2),
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 245, 174, 1),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/respiclick.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 160,
                            height: 48,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Nama Inhaler',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Raleway"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //END OF INHALER KETIGA

                ],
              ),
              //END OF LISTVIEW

            )
          ],
        ),
      ),
    );
  }
}
