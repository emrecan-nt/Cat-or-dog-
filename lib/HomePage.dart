import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFEFEFE),
        appBar: AppBar(
          backgroundColor: Color(0xFFC2FB09),
          centerTitle: true,
          title: SizedBox(
            width: 261,
            height: 73,
            child: SizedBox(
              width: 261,
              height: 73,
              child: Text(
                'Cat or Dog',
                style: GoogleFonts.inriaSerif(
                  color: Color(0xFF2C056E),
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: 347,
              height: 347,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/cat.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 320,
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/dog.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  print("tıklandı");
                },
                child: Container(
                  width: 238,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC2FB09),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Take a photo',
                      style: GoogleFonts.inriaSerif(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
