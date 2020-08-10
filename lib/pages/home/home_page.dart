import 'package:flutter/material.dart';
import 'package:nubank_clone/pages/home/widgets/bottom_menu/bottom_menu.dart';
import 'package:nubank_clone/pages/home/widgets/menu/menu_app.dart';
import 'package:nubank_clone/pages/home/widgets/my_app_bar.dart';
import 'package:nubank_clone/pages/home/widgets/page_view/my_dots_app.dart';
import 'package:nubank_clone/pages/home/widgets/page_view/page_view_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showMenu;
  int _currentIndex;
  double _yPosition;
  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    if (_yPosition == null) {
      _yPosition = _screenHeight * .24;
    }
    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MyAppBar(
            showMenu: _showMenu,
            onTap: () {
              setState(() {
                _showMenu = !_showMenu;
                _yPosition =
                    _showMenu ? _screenHeight * .85 : _screenHeight * .24;
              });
            },
          ),
          MenuApp(
            top: _screenHeight * .20,
            showMenu: _showMenu,
          ),
          BottomMenu(
            showMenu: _showMenu,
          ),
          MyDotApp(
            showMenu: _showMenu,
            top: _screenHeight * .70,
            currentIndex: _currentIndex,
          ),
          PageViewApp(
            showMenu: _showMenu,
            top:
                _yPosition, //_showMenu ? _screenHeight * .85 : _screenHeight * .24,
            onChanged: (index) => {
              setState(() {
                _currentIndex = index;
              })
            },
            onPanUpdate: (details) {
              double positionTopLimit = _screenHeight * .24;
              double positionBottomLimit = _screenHeight * .85;
              double middlePosition = positionBottomLimit - positionTopLimit;
              middlePosition /= 2;
              setState(() {
                _yPosition += details.delta.dy;
                _yPosition = _yPosition < positionTopLimit
                    ? positionTopLimit
                    : _yPosition;
                _yPosition = _yPosition > positionBottomLimit
                    ? positionBottomLimit
                    : _yPosition;
                if (_yPosition != positionTopLimit && details.delta.dy < 0) {
                  _yPosition = _yPosition < positionBottomLimit - middlePosition
                      ? positionTopLimit
                      : _yPosition;
                }
                if (_yPosition != positionBottomLimit && details.delta.dy > 0) {
                  _yPosition =
                      _yPosition > positionTopLimit + middlePosition - 50
                          ? positionBottomLimit
                          : _yPosition;
                }
                if (_yPosition == positionBottomLimit) {
                  _showMenu = true;
                } else if (_yPosition == positionTopLimit) {
                  _showMenu = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
