import 'package:flutter/material.dart';

class MenuCell extends StatefulWidget {
  const MenuCell({
    Key key,
    this.name,
    this.menu,
  }) : super(key: key);

  final String name;
  final IconData menu;

  @override
  State<StatefulWidget> createState() {
    return _MenuCell();
  }
}

class _MenuCell extends State<MenuCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              widget.menu,
              color: Colors.black38,
              size: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.name,
              style: TextStyle(fontFamily: 'Ralway', fontSize: 18),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Text(""),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 1.0,
          color: Colors.black38,
        )
      ],
    );
  }
}
