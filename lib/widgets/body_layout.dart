import 'package:daily_music/artist.dart';
import 'package:daily_music/constants.dart';
import 'package:daily_music/detail_page.dart';
import 'package:daily_music/distance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

const _initialPage = 1.0;


class BodyLayout extends StatefulWidget {
  final int indexSelected;
  final void Function(double d) onTap;
  const BodyLayout({super.key, required this.indexSelected,required this.onTap});

  @override
  State<BodyLayout> createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  final _listArtistController = PageController(
    viewportFraction: 0.55,
    initialPage: _initialPage.toInt()
   /*  initialScrollOffset: _initialPage */
  );
  double _currentPage = _initialPage;
  double? itemSize;
  final distanceBloc = DistanceBloc();


  void _listArtistScrollListener() {
    setState(() {
      _currentPage = _listArtistController.page ?? 0.0;
    });
  }

  @override
  void initState() {
    _listArtistController.addListener(_listArtistScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _listArtistController.removeListener(_listArtistScrollListener);
    // TODO: implement dispose
    _listArtistController.dispose();
    distanceBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    itemSize = MediaQuery.of(context).size.width * 0.45;
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: _cardsWrapper(context),
      ),
    );
  }

  Widget _cardsWrapper(BuildContext context) {
    
    return PageView.builder(
      controller: _listArtistController,
      scrollDirection: Axis.horizontal,
      itemCount: artists[widget.indexSelected].musics!.length + 1,
      itemBuilder: (context,i){
        if(i==0) {
          return _sideBarMenu();
        }
        
        final distance = (_currentPage - i).abs();
        double h = (1-distance).clamp(0.82, 1.0);
    
        widget.onTap(distance);
            
            /* print('s: ${}'); */
        final el = artists[widget.indexSelected].musics![i-1];
        final artist = artists[widget.indexSelected];
    
        return _cardArtist(context,el,artist,h);
      },
    );
  }

  Widget _cardArtist(BuildContext context,Music el,Artist artist,double customHeight) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topCenter,
      child: FractionallySizedBox(
        heightFactor: customHeight,
        widthFactor: 1.0,
        child: Card(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(right: size.width * 0.04,bottom: (customHeight > 0.85) ? 50 : 30),
          semanticContainer: true,
          surfaceTintColor: Colors.white,
          elevation: 25,
          child: SizedBox(
            height: double.infinity,
            width: size.width * 0.55,  
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: '${artist.name}_${el.title}',
                      child: Image.asset(
                        el.image,
                        fit: BoxFit.cover, 
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 0.05,0,size.width * 0.05,size.height *0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.02,),
                        Text(artist.name,
                          style: GoogleFonts.abrilFatface(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey
                          ),
                        ),
                        /* SizedBox(height: size.height * 0.02,), */
                        SizedBox(height: 20),
                        Text(el.title,
                          style: GoogleFonts.abrilFatface(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        /* SizedBox(height: size.height * 0.03,), */
                        SizedBox(height: 20,),
                        Row(
                          children: List.generate(
                            el.tags.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: size.width * 0.02),
                              child: CircleAvatar(
                                backgroundColor: secondarylightBrown,
                                child: Text(el.tags[index],
                                  style: GoogleFonts.roboto(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ),
                        ),
                        /* SizedBox(height: size.height * 0.02), */
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mark',
                              style: GoogleFonts.abrilFatface(
                                color: Colors.grey
                              ),
                            ),
                            Text('/',
                              style:TextStyle(color: Colors.grey)
                            ),
                            Text('${(el.mark).toString()}',
                              style: GoogleFonts.abrilFatface(
                                fontSize: 20
                              ),
                            ),
                            Row(
                              children: List.generate(el.mark.toInt(), (index) => Icon(Icons.star,size: size.width * 0.02,color: secondarylightBrown,)),
                            )
                          ],
                        ),                        /* SizedBox(height: size.height * 0.059,), */
                        Spacer(),
                        Visibility(
                          visible: (customHeight > 0.9) ? true : false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 350),
                                      pageBuilder:  (context,animation,_) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: DetailPage(artist: artist,music: el),
                                        );
                                      }
                                    )
                                  );
                                },
                                child: Text('Start Listening To Songs',
                                  style: GoogleFonts.abrilFatface(
                                    fontSize: 14
                                  ),
                                ),
                              ),
                              /* SizedBox(height: size.height * 0.005,), */
                              SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sideBarMenu() {
    return Container(
      height: double.infinity,
      child: FractionallySizedBox(
        alignment: Alignment.centerRight,
        widthFactor: 0.4,
        heightFactor: 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -math.pi/2,
              child: Text('Classical',
                style: GoogleFonts.abrilFatface(
                  fontSize: 16,
                )
              ),
            ),
            SizedBox(height: 80,),
            Transform.rotate(
              angle: -math.pi/2,
              child: Text('Popular',
                style: GoogleFonts.abrilFatface(
                  fontSize: 16,
                )
              ),
            ),
            SizedBox(height: 80,),
            Transform.rotate(
              angle: -math.pi/2,
              child: Text('Nationality',
                style: GoogleFonts.abrilFatface(
                    fontSize: 16
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}