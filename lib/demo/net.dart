import 'package:flutter/material.dart';


class NetPage extends StatefulWidget {
  NetPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NetPageState createState() => _NetPageState();
}

class _NetPageState extends State<NetPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'Ysss',
            ),

          ],
        ),
      ),

    );
  }
}