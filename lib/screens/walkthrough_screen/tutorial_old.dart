import 'dart:io';
import 'package:door_shop/services/database/walkthrough_data.dart';
import 'package:door_shop/screens/screens.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';


// TODO: make this container scrollable and put keyboard false
class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  
  List slides = <SliderModel>[];
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
  }
  
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          onPageChanged: (val){
            setState(() {
              currentIndex = val;
            });
          },
          itemBuilder: (context, index){
            return SliderTile(
              imagePath: slides[index].getImagePath(),
              title: slides[index].getTitle(),
              description: slides[index].getDescription(),
            );
          },
        ),
        bottomSheet: currentIndex != slides.length - 1 ? Container(
          height: Platform.isIOS ? 70 : 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Text("SKIP"),
                onTap: (){
                  // TODO: Test and check on the curve and the duration
                  pageController.animateToPage(slides.length-1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
              ),
              DotsIndicator(
                dotsCount: slides.length,
                position: currentIndex.toDouble(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  activeColor: Palette.primaryColor
                ),
              ),
              GestureDetector(
                child: Text("NEXT"),
                onTap: (){
                  // TODO: Test and check on the curve and the duration
                  pageController.animateToPage(currentIndex+1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
              )
            ]
          ),
        ) : Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: Platform.isIOS ? 70 : 60,
          color: Palette.primaryColor,
          child:
            TextButton(
              // TODO: If this still doesn't works, then we'll make this elevated button with elevation 0
              onPressed: (){
                Navigator.push(
                  context,
                  // TODO: Resolve, work around with shared preference
                  MaterialPageRoute(builder: (context) => LoginPage())
                );
              },
              // Check if the text button is the right choice
              // TODO: change this into button so that whole bottom is onTap enabled, still not working, check with the login and register page
              child: Text(
                "GET STARTED", // Check by making this text lower case
                style: Palette.buttonTextStyle
              ),
            ) 
        ),
      ),
    );
  }
}

class SliderTile extends StatelessWidget {
  
  // TODO: check if final or const will work or not, after checking remove this comment
  final String imagePath, title, description;
  SliderTile({@required this.imagePath, @required this.title, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          SizedBox(height: 20),
          Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
          SizedBox(height: 12),
          Text(description, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ))
        ],
      ),
    );
  }
}