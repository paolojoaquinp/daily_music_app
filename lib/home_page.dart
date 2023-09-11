import 'package:daily_music/artist.dart';
import 'package:daily_music/constants.dart';
import 'package:daily_music/distance_bloc.dart';
import 'package:daily_music/widgets/body_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/custom_app_bar.dart';

const double leftPadding = 90.0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int artistSelected = 0;
  final distanceBloc = DistanceBloc();

  void updateDistance(double d) {
    distanceBloc.updateDistance(d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGrey,
      body: Column(
      children: [
        StreamBuilder<double>(
          stream: distanceBloc.distanceStream,
          initialData: 0.0,
          builder: (context, snapshot) {
            final distance = snapshot.data!;
            return CustomAppBar(distance: distance,);
          }
        ),
        BodyLayout(indexSelected: artistSelected,onTap: updateDistance,),
        _customBottomNavBar(),
      ],
    ));
  }


  Widget _customBottomNavBar() {
    final sizeIcon = 30.0;
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.13,
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: leftPadding,
              child: CircleAvatar(
                radius: sizeIcon,
                backgroundColor: secondaryBlack,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: sizeIcon,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: artists.length + 1,
                itemBuilder: (context, index) {
                  if(index == 0) return SizedBox(width: size.width * 0.05,);
                  return Align(
                    alignment: Alignment.topCenter,
                    child: FractionallySizedBox(
                      heightFactor: 0.7,
                      child: Column(
                        children: [
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              color: artistSelected == (index-1) ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(50)
                            ),
                          ),
                          TextButton(
                            child: Text(artists[index-1].name,
                              style: GoogleFonts.abrilFatface(
                                color: Colors.black
                              )
                            ),
                            onPressed: () {
                              setState(() {
                                artistSelected = (index-1);
                              });
                            },
                          ),
                        ],
                      )
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
