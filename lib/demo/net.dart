import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_study/common/Config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetPage extends StatefulWidget {
  NetPage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _NetPageState createState() => _NetPageState();
}

class _NetPageState extends State<NetPage> {
  String _searchValue='';
  final TextEditingController _controller = new TextEditingController();
  var _result = '';
  var _decodeResult;
  String curImageUrl = '';
  //使用系统的请求
  var httpClient = new HttpClient();
  _loadData() async {
    _controller.text='';
    try {
      var request = await httpClient.getUrl(Uri.parse(Config.apiUrl));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        _result = await response.transform(Utf8Decoder()).join();

        setState(
          () {
            _decodeResult= jsonDecode(_result);
          }
        );

      } else {
        _result = 'error code : ${response.statusCode}';
      }
    } catch (exception) {
      _result = '网络异常';
    }
    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left:20.0,  top: 10.0, bottom: 10.0,right:20.0),
            child: new Text('随便问点什么？', style: new TextStyle(fontSize: 18.0)),
          ),
          new Padding(
            padding: new EdgeInsets.only(left:20.0,right:20.0),
            child: new TextField(
              controller: _controller,
              onChanged: (str) {
                setState(() { _searchValue = str;});
              },
              decoration: new InputDecoration(
                hintText: '请输入英文或数字',
              ),
              maxLines: 1,

            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(left:20.0,  top: 10.0, bottom: 10.0,right:20.0),
            child: new RaisedButton(
              onPressed: _loadData,
              color: Colors.blue,//按钮的背景颜色
              child: new Text('是否？'),
              textColor: Colors.white,//文字的颜色
              textTheme:ButtonTextTheme.normal ,//按钮的主题
              highlightColor: Colors.yellowAccent,//点击或者toch控件高亮的时候显示在控件上面，水波纹下面的颜色
              splashColor: Colors.white,//水波纹的颜色
              colorBrightness: Brightness.light,//按钮主题高亮
              elevation: 10.0,//按钮下面的阴影
              highlightElevation: 10.0,//高亮时候的阴影
              disabledElevation: 10.0,//按下的时候的阴影

            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(left:20.0,  top: 10.0, bottom: 10.0,right:20.0),
            child: new Text('Question:$_searchValue'+(_searchValue.length<=0?'':'?'), style: new TextStyle(fontSize: 18.0)),
          ),
          new Padding(
            padding: new EdgeInsets.only(left:20.0,  top: 10.0, bottom: 10.0,right:20.0),
            child: new Text('Answer:'+(_decodeResult!=null?_decodeResult['answer']:''), style: new TextStyle(fontSize: 18.0)),
          ),
          new Padding(
            padding: new EdgeInsets.only(left:20.0,  top: 10.0, bottom: 10.0,right:20.0),
            child: new Image.network(_decodeResult!=null?_decodeResult['image']:''),
          ),
        ],
      ),

    );
  }
}

