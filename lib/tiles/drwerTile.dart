import 'package:flutter/material.dart';
class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController _controller;
  final int page;

 DrawerTile(this.text, this.icon, this._controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          _controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                  icon,
                size: 32.0,
                color: _controller.page!.round() == page?
                Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32.0,),
              Text(text,style: TextStyle(
                fontSize: 16.0,
                color: _controller.page!.round() == page?
                Theme.of(context).primaryColor : Colors.grey[700],
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
