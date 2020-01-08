import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/firebase/auth.dart';
import 'package:ticknote/src/model/User.dart';
import 'package:ticknote/src/preferences/userPreferences.dart';
import 'package:ticknote/src/widgets/category.dart';
import 'package:ticknote/src/widgets/note.dart';
import 'package:ticknote/src/widgets/profile.dart';
import 'package:ticknote/src/widgets/rectangleOrange.dart';
import 'package:ticknote/src/widgets/cardNote.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RectangleOrange, SingleTickerProviderStateMixin{

  TabController _tabController;
  User user;

  final _preferences  = UserPreferences();
  final _auth         = Auth();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    user = User.fromJson(jsonDecode(_preferences.profile));
  }

  @override
  Widget build(BuildContext context) {

    final uiBloc  = Provider.ui(context);
    final size    = MediaQuery.of(context).size;

    final _appBar = Container(
      height: size.height * 0.12,
      width: size.width,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('TickNote', style: TextStyle(color: Colors.white),),
      ),
    );

    final _photoProfile = Positioned(
      right: size.width * 0.03,
      top:  size.height * 0.05,
      child: StreamBuilder<int>(
        stream: uiBloc.tabIndexStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          print('data: ${snapshot.data}');
          return snapshot.data != 2 ? Hero(
            tag: 'picture',
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: size.height * 0.03,
            ),
          ) : Container();

        },
      )
    );
    
    final _contentPages = Container(
      height: size.height,
      width: size.width,
      margin: EdgeInsets.only(top: size.height * 0.14, bottom: size.height * 0.1),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Note(),
          Category(),
          Profile()
        ],
      ),
    );

    final _bottomNavBar = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(right: size.width * 0.27),
        height: size.height * 0.09,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white70,//Color.fromRGBO(255, 137, 60, 1).withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home, color: Colors.black54,), text: 'Inicio'),
            Tab(icon: Icon(Icons.format_list_bulleted, color: Colors.black54,), text: 'Categorias',),
            Tab(icon: Icon(Icons.person_outline, color: Colors.black54), text: 'Perfil',),
          ],
          onTap: (index){uiBloc.tabIndexChange(index); print(uiBloc.tabIndex);}
        )
      ),
    );

    final _floatingButton = MaterialButton(
      elevation: 7.0,
      splashColor: Colors.yellow.withOpacity(0.5),
      color: Color.fromRGBO(252, 111, 101, 1),
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: size.height* 0.09,
        width: size.width * 0.09,
        child: Center(child: Icon(Icons.add, color: Colors.white, size: 40,)),
      ),
      onPressed: () {
        uiBloc.colorChange(Color.fromRGBO(233, 234, 236, 1));
        uiBloc.titleChange('');
        uiBloc.descChange('');
         Navigator.of(context).pushNamed('addNote');
      },
    );

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(233, 233, 233, 1),//Color.fromRGBO(57, 57, 55, 1),//Color.fromRGBO(114, 117, 98, 1),,
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[

            Positioned(
              left: -50,
              child: rectangleOrange(context, size)
            ),
            Positioned(
              left: size.width * 0.33,
              top: -10,
              child: rectangleRed(context, size),
            ),

            _appBar,
            _tabController.index != 2 ? _photoProfile : Container(),
            _contentPages,
            _bottomNavBar,
            loading ? Container(
              height: size.height,
              width: size.width,
              color: Colors.grey.withOpacity(0.4),
              child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange))),
            ) : Container()
          ],
        ),
      ),

      floatingActionButton: _floatingButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}