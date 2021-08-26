import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
        height: 50,
        margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 57.6,
              width: 57.6,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.6),
                color: Color(0x080a0928),
              ),
              child: new SvgPicture.asset('assets/images/icon_drawer.svg'),
            ),
            Text(
              'Restaurants App',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 25.0, fontWeight: FontWeight.w700),
            ),
            Container(
                height: 57.6,
                width: 57.6,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.6),
                  color: Color(0x080a0928),
                ),
                child: CircleAvatar(
                  child: Image.asset('assets/images/avatar.png'),
                )),
          ],
        ),
      );
}
