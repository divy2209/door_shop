import 'dart:io';
import 'dart:ui';

import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/register_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ImagePick extends StatelessWidget {
  final String form;
  final File imageFile;
  ImagePick({@required this.form, this.imageFile});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: CircleAvatar(
                radius: size.width * 0.14,
                backgroundColor: Colors.grey[400].withOpacity(0.4),
                backgroundImage: imageFile==null ? null : FileImage(imageFile),
                child: imageFile==null ? Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                  size: size.width * 0.1,
                ) : null,
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.08,
          left: size.width * 0.56,
          child: Container(
            height: size.width * 0.1,
            width: size.width * 0.1,
            decoration: BoxDecoration(
                color: Palette.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2)
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () async {
                if(await Permission.camera.request().isGranted && await Permission.storage.request().isGranted){
                  if(form == FormIdentifier.register){
                    Provider.of<RegisterData>(context, listen: false).getImage();
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Camera and Gallery Permission'),
                        content: Text(
                            'This app needs camera and gallery access to take pictures for upload crop profile photo'),
                        actions: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: [
                                TextButton(
                                  child: Text('Deny'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                Spacer(),
                                TextButton(
                                  child: Text('Settings'),
                                  onPressed: (){
                                    openAppSettings();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                }
              },
              child: Icon(
                FontAwesomeIcons.arrowUp,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
