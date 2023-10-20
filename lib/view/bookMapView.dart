import 'package:bookmap_ver2/controller/bookMapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bookMapDetailView.dart';

import '../asset.dart';

class BookMap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BookMapState();
  }
}

class BookMapState extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => BoockMapTapState();
}

class BoockMapTapState extends State<BookMapState> with SingleTickerProviderStateMixin{
  late TabController bookMapTapController;
  final BookMapController bookMapController = Get.put(BookMapController());
  @override
  void initState(){
    super.initState();
    bookMapTapController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // bookMapController.fetchData();
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: bookMapTapController,
              isScrollable: true,
              labelColor: appColor.shade900,
              unselectedLabelColor: appColor.shade800,
              labelStyle: const TextStyle(fontFamily: "Pretendard", fontSize: 16, fontWeight: FontWeight.w600),
              indicator: CircleTabIndicator(color: appColor.shade900, radius: 4),
              indicatorColor: appColor.shade700,
              tabs: const [
                // Tab(text: "All"),
                Tab(text: "내가 만든"),
                Tab(text: "스크랩"),
              ],
            ),
          ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: Obx((){
            return SizedBox(
              width: double.maxFinite,
              height: (MediaQuery.of(context).size.height - 240),
              child: TabBarView(
                controller: bookMapTapController,
                children: [
                      //전체
                  // NotificationListener(
                  //   onNotification: (OverscrollIndicatorNotification overscroll) {
                  //     overscroll.disallowIndicator();
                  //     return true;
                  //     },
                  //   child: ListView.builder(
                  //     itemCount: bookMapController.allBookMaps.length,
                  //     itemBuilder: (context, index){
                  //       return GestureDetector(
                  //         onTap: (){
                  //           Get.to(() =>
                  //               BookMapDetailView(),
                  //               arguments: bookMapController.allBookMaps[index].bookMapId
                  //           );},
                  //         child: Card(
                  //           surfaceTintColor: appColor,
                  //               margin: EdgeInsets.all(12),
                  //               child: Padding(
                  //                 padding: EdgeInsets.all(16),
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                         flex: 3,
                  //                         child: (bookMapController.allBookMaps[index].bookMapImage == null)
                  //                             ? Image.asset('src/sampleBook.jpg')
                  //                             : Image.network(bookMapController.allBookMaps[index].bookMapImage ?? "", fit: BoxFit.fitWidth, width: 50,)),
                  //                     const Spacer(
                  //                       flex: 1,
                  //                     ),
                  //                     Expanded(
                  //                       flex: 11,
                  //                       child: Column(
                  //                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                         children: [
                  //                           Column(
                  //                             crossAxisAlignment: CrossAxisAlignment.start,
                  //                             children: [
                  //                               Padding(padding: EdgeInsets.only(bottom: 10)),
                  //                               Text('${bookMapController.allBookMaps[index].bookMapTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                  //                               Text('${bookMapController.allBookMaps[index].nickname}', style: TextStyle(fontSize: 14, fontFamily: 'Pretendard'),)
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                      //내가 만든 sort:1
                      NotificationListener(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: bookMapController.myBookMaps.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                Get.to(() =>
                                    BookMapDetailView(),
                                    arguments: bookMapController.myBookMaps[index].bookMapId);
                              },
                              child: Card(
                                surfaceTintColor: appColor,
                                margin: EdgeInsets.all(12),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: (bookMapController.myBookMaps[index].bookMapImage == null)
                                              ? Image.asset('src/sampleBook.jpg')
                                              : Image.network(bookMapController.myBookMaps[index].bookMapImage ?? "", fit: BoxFit.fitWidth, width: 50,)),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      Expanded(
                                        flex: 11,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                                Text('${bookMapController.myBookMaps[index].bookMapTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                                Text(makeHash(bookMapController.myBookMaps[index].hashTag).join(" "), style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                                                Text('${bookMapController.myBookMaps[index].nickname}', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      //스크랩
                      NotificationListener(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: bookMapController.scrapBookMaps.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                Get.to(() =>
                                    BookMapDetailView(),
                                    arguments: bookMapController.scrapBookMaps[index].bookMapId);
                              },
                              child: Card(
                                surfaceTintColor: appColor,
                                margin: EdgeInsets.all(12),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: (bookMapController.scrapBookMaps[index].bookMapImage == null)
                                              ? Image.asset('src/sampleBook.jpg')
                                              : Image.network(bookMapController.scrapBookMaps[index].bookMapImage ?? "", fit: BoxFit.fitWidth, width: 50,)),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      Expanded(
                                        flex: 11,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                                Text('${bookMapController.scrapBookMaps[index].bookMapTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                                Text(makeHash(bookMapController.scrapBookMaps[index].hashTag).join(" "), style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                                                Text('${bookMapController.scrapBookMaps[index].nickname}', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],),
                );
              }),
          ),
      ],
    );
  }
}

// TabBar indicator decoration
class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}
class _CirclePainter extends BoxPainter{
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint ..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

List<String> makeHash(List<String>? tags) {
  List<String> newHash = [];
  tags?.forEach((tag) {
    if (tag.trim().isNotEmpty){
      newHash.add("#" + tag);
    }
  });
  return newHash;
}