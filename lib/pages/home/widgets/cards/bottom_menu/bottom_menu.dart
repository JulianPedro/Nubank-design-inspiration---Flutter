import 'package:flutter/material.dart';
import 'package:nubank_clone/pages/home/widgets/bottom_menu/item_menu_bottom.dart';

class BottomMenu extends StatefulWidget {
  final bool showMenu;
  const BottomMenu({Key key, this.showMenu}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _tween = Tween<double>(begin: 150.0, end: 150.0);
    delayAnimation();
  }

  Future<void> delayAnimation() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _tween = Tween<double>(begin: 150.0, end: 0.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: _tween,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return AnimatedPositioned(
            bottom: widget.showMenu ? 0 : MediaQuery.of(context).padding.bottom,
            duration: Duration(milliseconds: 200),
            left: value,
            right: value * -1,
            height: MediaQuery.of(context).size.height * 0.16,
            child: IgnorePointer(
              ignoring: widget.showMenu,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: widget.showMenu ? 0 : 1,
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ItemMenuBottom(
                          icon: Icons.person_add, text: 'Indicar Amigos'),
                      ItemMenuBottom(
                          icon: Icons.phone_android,
                          text: 'Recarga de celular'),
                      ItemMenuBottom(icon: Icons.chat, text: 'Cobrar'),
                      ItemMenuBottom(
                          icon: Icons.monetization_on, text: 'Empréstimo'),
                      ItemMenuBottom(
                          icon: Icons.move_to_inbox, text: 'Depositar'),
                      ItemMenuBottom(
                          icon: Icons.mobile_screen_share, text: 'Transferir'),
                      ItemMenuBottom(
                          icon: Icons.format_align_center,
                          text: 'Ajustar limite'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
