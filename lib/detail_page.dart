import 'package:daily_music/artist.dart';
import 'package:daily_music/constants.dart';
import 'package:daily_music/share_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum PlayerState { show, hide, proccessing }

class DetailPage extends StatefulWidget {
  final Artist artist;
  final Music music;
  const DetailPage({super.key, required this.artist, required this.music});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  ScrollController? _controller;
  PlayerState _playerState = PlayerState.hide;
  double clampedValue = 0.0;
  late final AnimationController _animationController;
  Animation<double>? animation;

  @override
  void initState() {
    _controller = ScrollController();
    _controller!.addListener(_onVerticalGestureListener);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    ); //
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller!.removeListener(_onVerticalGestureListener);
    _controller!.dispose();
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void _onVerticalGestureListener() {
    final double offset = _controller!.offset;

    const double lowerBound = -110.0;
    const double upperBound = 12.0;

    clampedValue = (offset - lowerBound) / (upperBound - lowerBound);
    clampedValue = clampedValue.clamp(0.0, 1.0); // Clamp entre 0.0 y 1.0
    clampedValue = 1 - clampedValue; // Clamp entre 0.0 y 1.0
    setState(() {});

    /* print('Clamped Value: $clampedValue'); */

    if (clampedValue > 0.6) {
      /* print('custom'); */
      _playerState = PlayerState.show;
      _animationController.forward(from: 0.0);
      /* bloc.changeToCart(); */
    } else if (clampedValue < 0.7 && clampedValue > 0.0) {}
    if (clampedValue > 0.01 && clampedValue < 0.6 && offset == 0.0) {
      setState(() {
        clampedValue = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(4.0, 5.0),
                        blurRadius: 50,
                      )
                    ]),
                    child: Hero(
                      tag: '${widget.artist.name}_${widget.music.title}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        child: Image.asset(
                          widget.music.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(top: 50, left: 30, child: BackButton()),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                controller: _controller,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  color: Colors.transparent,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.music.title,
                        style: GoogleFonts.abrilFatface(fontSize: 30),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Text(widget.artist.name,
                          style: GoogleFonts.abrilFatface(
                              fontSize: 20, color: greenGreyLight)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Row(
                        children: List.generate(
                            widget.music.types.length,
                            (index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  margin: EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: secondarylightBrown,
                                  ),
                                  child: Text(
                                    widget.music.types[index],
                                    style: GoogleFonts.abrilFatface(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            ListWheelScrollView(
                              physics: BouncingScrollPhysics(),
                              itemExtent: 28,
                              diameterRatio: 2.5,
                              children: widget.music.lyrics.map((linea) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(linea,
                                            style: GoogleFonts.abrilFatface(
                                                fontSize: 20,
                                                letterSpacing: -0.2,
                                                height: -0.5,
                                                color:
                                                    Colors.black.withOpacity(0.6))),
                                      ))
                                  .toList(),
                            ),
                            Container(
                              height: 9,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.0,8.0),
                                    color: Colors.white,
                                    blurRadius: 13.0
                                  )
                                ]
                              )
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 9,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.0,-8.0),
                                      color: Colors.white,
                                      blurRadius: 13.0
                                    )
                                  ]
                                )
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.55,
          child: FractionallySizedBox(
            widthFactor: 0.2,
            child: _playerWidget(),
          ),
        )
      ],
     )
    );
  }

  Widget _playerWidget() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          curve: Curves.elasticOut,
          duration: Duration(milliseconds: 700),
          bottom: _playerState == PlayerState.show
              ? 70
              : ((clampedValue) * 70) + 10,
          left:
              _playerState == PlayerState.show ? -100 : (clampedValue) * (-100),
          child: GestureDetector(
            onTap: () => print('asolaso'),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 32,
                child: SvgPicture.asset(
                  'assets/reverse-icon.svg',
                  width: 22,
                )),
          ),
        ),
        AnimatedPositioned(
          curve: Curves.elasticOut,
          duration: Duration(milliseconds: 700),
          bottom:
              _playerState == PlayerState.show ? 70 : clampedValue * 70 + 10,
          right:
              _playerState == PlayerState.show ? -100 : clampedValue * (-100),
          child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                'assets/skip-icon.svg',
                width: 22,
              )),
        ),
        AnimatedPositioned(
          curve: Curves.elasticOut,
          duration: Duration(milliseconds: 700),
          left: 0,
          right: 0,
          bottom: _playerState == PlayerState.show 
            ? 120 
            : clampedValue * (120) + 5,
          child: GestureDetector(
             onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 350),
                  pageBuilder:  (context,animation,_) {
                    return FadeTransition(
                      opacity: animation,
                      child: SharePage(artist: widget.artist,music: widget.music),
                    );
                  }
                )
              );
            },
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 32,
                child: Image.asset(
                  'assets/paper-plane.png',
                  width: 22,
                )),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 45,
            child: Icon(
              Icons.play_arrow,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
