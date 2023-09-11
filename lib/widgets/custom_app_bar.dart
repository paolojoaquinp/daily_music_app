import 'package:daily_music/constants.dart';
import 'package:daily_music/distance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_page.dart' as hp;

class CustomAppBar extends StatefulWidget {
  final double distance;
  const CustomAppBar({super.key, required this.distance});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final distanceBloc = DistanceBloc();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          children: [
            /* Text((widget.distance)!.toStringAsFixed(2)), */
            SizedBox(
              width: hp.leftPadding,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Daily',
                        style: GoogleFonts.abrilFatface(
                            fontWeight: FontWeight.w500, fontSize: 44.0)),
                    Text('Recomended',
                        style: GoogleFonts.abrilFatface(
                            color: greenGreyLight, fontSize: 24.0))
                  ],
                ),
              ),
            ),
            _dotsViewIndicator(context,widget.distance)
          ],
        ),
    );
  }

  Widget _dotsViewIndicator(BuildContext context,double value) {
    return Container(
      padding: EdgeInsets.only(left: value * 15),
      width: MediaQuery.of(context).size.width * 0.2,
      child: Stack(
        children: List.generate(
          3 ,
          (index) {
            return Positioned(
              bottom: 70,
              left: (value*17)*(index.toDouble()),
              child: Transform.rotate(
                angle: 150.0,
                origin: Offset(0.0, 0.0),
                child: Container(
                  width: 8,
                  height: 8,
                  color: primaryBlack,
                ),
              ),
            );
          })
      )
    );
  }
}
