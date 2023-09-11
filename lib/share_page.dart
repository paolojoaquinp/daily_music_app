import 'dart:math' as math;

import 'package:daily_music/artist.dart';
import 'package:daily_music/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharePage extends StatefulWidget {
  final Artist artist;
  final Music music;
  const SharePage({super.key, required this.artist, required this.music});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  
  ScrollController? _scrollController1;
  ScrollController? _scrollController2;

  List<int> _indexArtistSelected = [];
  bool _isTapped = false;

  

  @override
  void initState() {
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    super.initState();
  }


  @override
  void dispose() {
    _scrollController1!.dispose();
    _scrollController2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xffF8F8F8),
        body: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffededed),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ListView.builder(
                                    controller: _scrollController1!..addListener(() {
                                        _scrollController2!.animateTo(_scrollController1!.offset,
                                        curve: Curves.easeInOut,
                                        duration: const Duration(milliseconds: 1));
                                    }),
                                    scrollDirection: Axis.vertical,
                                    itemCount: artists.length + 1,
                                    itemBuilder: (_, index) {
                                      if (index == 0) {
                                        return SizedBox(
                                          height: size.width * 0.2,
                                        );
                                      }
                                      final artist = artists[index - 1];
                                      if (artist.name == widget.artist.name) {
                                        return SizedBox.shrink();
                                      }
                                      return TweenAnimationBuilder<double>(
                                          curve: Curves.bounceIn,
                                          duration: Duration(
                                              milliseconds: (150 * index).toInt()),
                                          tween: Tween(begin: -30.0, end: size.height),
                                          builder: (context, value, _) {
                                            return Transform.translate(
                                              offset: Offset(0.0, (size.height) - value),
                                              child: _itemList(artist, index)
                                            );
                                          });
                                    },
                                  ),
                                ],
                              )),
                        ),
                        Positioned(
                            top: -size.height * 0.4,
                            child: _cardArtist(context)
                        ),
                        IgnorePointer(
                          child: Positioned(
                            top: 0,
                            child: Container(
                              width: size.width,
                              height: size.height,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(right:40),
                              child: FractionallySizedBox(
                                widthFactor: 0.1,
                                heightFactor: 1.0,alignment: Alignment.centerRight,
                                child: ListView.builder(
                                  controller: _scrollController2,
                                  scrollDirection: Axis.vertical,
                                  itemCount: artists.length + 1,
                                  itemBuilder: (_, index) {
                                    if (index == 0) {
                                      return SizedBox(
                                        height: size.width * 0.2,
                                      );
                                    }
                                    final artist = artists[index - 1];
                                    if (artist.name == widget.artist.name) {
                                      return SizedBox.shrink();
                                    }
                                    if (_indexArtistSelected.contains(index-1)) {
                                      return _cardArtistCover();
                                    }
                                    return SizedBox(
                                      height: size.width * 0.2,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  )
              ],
            ),
            Positioned(
              bottom: 70,
              right: 35,
              child: GestureDetector(
              onLongPress: () {
                setState(() {
                  _isTapped = !_isTapped;
                });
                () async {
                  Future.delayed(Duration(milliseconds: 1500),() {
                    Navigator.pop(context);
                  });
                }();
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Image.asset(
                        'assets/paper-plane.png',
                        width: 22,
                      ),
                ),
              )
            ),
          ],
        ),
    );
  }

  Widget _itemList(Artist artist, int index) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: size.width * 0.15,
      padding: EdgeInsets.only(right: size.width * 0.08),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                if (_indexArtistSelected.contains(index - 1)) {
                  setState(() {
                    _indexArtistSelected.remove(index - 1);
                  });
                } else {
                  setState(() {
                    _indexArtistSelected.add(index - 1);
                  });
                }
              },
              child: CircleAvatar(
                backgroundColor: _indexArtistSelected.contains(index - 1)
                    ? secondarylightBrown
                    : Colors.grey.withOpacity(0.3),
                radius: 20,
                child: CircleAvatar(
                  radius: 19,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  backgroundColor: _indexArtistSelected.contains(index - 1)
                      ? secondarylightBrown
                      : Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  width: size.width * 0.15,
                  height: size.width * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image.asset(
                      artist.musics!.first.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(artist.name,
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardArtistCover() {
    final size = MediaQuery.of(context).size;
    return Positioned.fill(
      child: Transform.rotate(
        angle: -math.pi/(-8),
        child: AnimatedOpacity(
          duration: Duration(seconds: 1),
          opacity: _isTapped ? 1.0 : 0.0,
          child: AnimatedContainer(
            width: size.width * 0.11,
            height: size.width * 0.11,
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(bottom: 15),
            duration: Duration(milliseconds: 800),
            transform: Matrix4.identity()
              ..translate(_isTapped ?  0.0 : -size.width, _isTapped ? 0.0 : -size.height * 0.3,0.0)
              ..scale(_isTapped ? 1.0 : 2.5),
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.01,
              right: MediaQuery.of(context).size.width * 0.01,
              top: MediaQuery.of(context).size.width * 0.01,
              bottom: MediaQuery.of(context).size.width * 0.025,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.asset(
                widget.music.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardArtist(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeCard = size.width * 0.75;
    return Container(
      width: sizeCard,
      height: size.width * 1.05,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                offset: Offset(10.0, 10.0),
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 25)
          ]),
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(size.width * 0.04),
          height: sizeCard,
          width: sizeCard,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Hero(
              tag: '${widget.artist.name}_${widget.music.title}',
              child: Image.asset(
                widget.music.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.music.title,
                style: GoogleFonts.abrilFatface(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.artist.name,
                style: GoogleFonts.abrilFatface(color: secondarylightBrown),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}