import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/pages/information.dart';

class InhalerCard extends StatelessWidget {
  final Map inhalerInfo;
  final int index;

  InhalerCard({Key key, @required this.inhalerInfo, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'yellow_container$index',
      child: Container(
          height: 320,
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: CustomColors.yellow,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  // offset: Offset(0, 2),
                )
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Information(
                              index: index,
                              inhalerInfo: inhalerInfo,
                            )));
              },
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 24.0,
                    bottom: 64.0,
                    child: Container(
                      height: 250.0,
                      width: 250.0,
                      child: Image.asset(
                        'assets/images/${inhalerInfo['name']}.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 320.0,
                      height: 48.0,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(
                        inhalerInfo['name'],
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
