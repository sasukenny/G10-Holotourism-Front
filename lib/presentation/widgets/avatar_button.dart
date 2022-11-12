import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarButton extends StatelessWidget{
  final double imageSize;
  const AvatarButton({Key? key, this.imageSize = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black26,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: 'https://thumbs.dreamstime.com/b/user-icon-male-hipster-avatar-vector-flat-design-user-icon-male-beard-icon-hipster-flat-icon-avatar-man-beard-flat-99281046.jpg',
              width: this.imageSize,
              height: this.imageSize,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.5,
                ),
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
