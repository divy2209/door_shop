import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CropImage extends StatelessWidget {
  final String url;
  CropImage({@required this.url});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: size.width*0.111,
      child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (context, url,
              downloadProgress) =>
              CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.black,),
          imageBuilder: (context, imageProvider) =>
              Container(
                decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    image:DecorationImage(
                        image:imageProvider,
                        fit: BoxFit.cover
                    )
                ),
              )
      ),
    );
  }
}
