import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/database/crop_model.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/crop_image.dart';
import 'package:door_shop/widgets/home_widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CropList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final crops = Provider.of<List<Crop>>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: crops==null ? Center(child: CircularProgressIndicator()) : Scrollbar(
        controller: _scrollController,
        thickness: 4,
        radius: Radius.circular(5),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: crops.length,
          itemBuilder: (context, index){
            Crop crop = crops[index];
            return crop.quantity>0 ? Card(
              elevation: 5,
              color: Colors.white,
              margin: EdgeInsets.all(size.width*0.026),
              child: Container(
                height: 110,
                margin: EdgeInsets.only(left: size.width*0.026),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CropImage(url: crop.url),
                    ),
                    SizedBox(width: size.width*0.05,),
                    Container(
                      height: 100,
                      width: size.width*0.61,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12),
                                  Text(crop.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  SizedBox(height: 22),
                                  Text(crop.unit, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),),
                                  SizedBox(height: 4),
                                ],
                              ),
                              Container(
                                height: 80,
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),
                                    CartButton(
                                      width: 90,
                                      radius: 15,
                                      label: "Add to cart",
                                      type: CartButtonIdentifier.home,
                                      crop: crop,
                                    ),
                                    SizedBox(height: 22),
                                    Text(crop.discount.toString() + "% Off!", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, fontWeight: FontWeight.bold, color: Palette.primaryColor)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("MRP: "),
                              crop.discount==0 ? Text('\u{20B9}' + crop.price.toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),) :
                              Row(
                                children: [
                                  Text('\u{20B9}' + crop.price.toString(), style: TextStyle(decoration: TextDecoration.lineThrough, fontStyle: FontStyle.italic, fontSize: 14),),
                                  Text(" " + '\u{20B9}' + (crop.price-crop.price*crop.discount/100).round().toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ) : SizedBox();
          },
        ),
      ),
    );
  }
}
