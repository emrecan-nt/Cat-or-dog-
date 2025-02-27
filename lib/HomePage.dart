import 'package:cat_or_dog/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFFF3EFDA) ,

      ),
      backgroundColor: Color(0xFFF3EFDA),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "DOG",
                style: GoogleFonts.kalam(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF6B898C),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/dog.png",
                fit: BoxFit.fill,
                width: 203.w,
              
              ),
            ),
            Text(
              "OR",
              style: GoogleFonts.kalam(
                fontSize: 48,
                fontWeight: FontWeight.w300,
                color: Color(0xFF6B898C),
              ),
            ),
            Image.asset("assets/images/cat.png", fit: BoxFit.fitWidth,
            width:217.w ,
            
            ),
            Text(
              "CAT",
              style: GoogleFonts.kalam(
                fontSize: 48,
                fontWeight: FontWeight.w300,
                color: Color(0xFF6B898C),
              ),
            ),
            GestureDetector(
      
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassificationScreen() ));
              },
              child: Expanded(
                child: Container(
                  
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:Color(0xFF6B898C),
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}