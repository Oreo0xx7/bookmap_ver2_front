import 'package:bookmap_ver2/controller/bookShelfModelController.dart';
import 'package:bookmap_ver2/view/librarySearchView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../asset.dart';
import '../controller/bookController.dart';
import 'BookDetailView.dart';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LibraryState();
  }
}

class LibraryState extends StatefulWidget{
  @override
  LibraryTabsState createState() => LibraryTabsState();
}

class LibraryTabsState extends State<LibraryState> with SingleTickerProviderStateMixin{
  final BookController bookController = Get.find<BookController>();
  final shelfController = Get.put(BookShelfModelController());
  late TabController libraryTapController;
  //late Future<List<dynamic>> fetchData;
  final List<String> bookTypeList = ['읽고 싶은', '읽고 있는', '읽은'];

  @override
  void initState(){
    super.initState();
    libraryTapController = TabController(initialIndex: 0, length: 4, vsync: this);
    // fetchData = _fetchData();
  }

  // 검색을 위한...
  final FocusNode _focusNode = FocusNode();
  int homeStatus = 0;
  // late TabController _tabController;
  // late TextEditingController? _editingController;
  // ScrollController? _scrollController;
  static List? data;
  int page = 1;
  String? searchQuery;


  @override
  Widget build(BuildContext context) {
     return Column(
       children: [
         SearchLibrary(),

         //탭 바
          Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: libraryTapController,
                isScrollable: true,
                labelColor: appColor.shade900,
                unselectedLabelColor: appColor.shade800,
                labelStyle: const TextStyle(fontFamily: "Pretendard", fontSize: 16, fontWeight: FontWeight.w600),
                indicator: CircleTabIndicator(color: appColor.shade900, radius: 4),
                indicatorColor: appColor.shade700,
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "읽고 싶은"),
                  Tab(text: "읽고 있는"),
                  Tab(text: "읽은"),
                ],
              ),
            ),
        Padding(padding: EdgeInsets.only(bottom: 10)),

         //탭 내부
         Expanded(
           child: GetX<BookController>(
               builder: (bookController) {
               return SizedBox(
                 width: double.maxFinite,
                 height: (MediaQuery.of(context).size.height * 0.6),
                 child: TabBarView(
                   controller: libraryTapController,
                   children: [
                     //전체
                     NotificationListener(
                               onNotification: (OverscrollIndicatorNotification overscroll) {
                                 overscroll.disallowIndicator();
                                 return true;
                               },
                               child: ListView.builder(
                                 itemCount: shelfController.shelfBooks.length,
                                 itemBuilder: (context, index){
                                   return GestureDetector(
                                     onTap: (){
                                       Get.to(
                                               () => ChangeNotifierProvider(
                                               create: (_) => BookProvider(),
                                               child: BookDetailView()),
                                           arguments: shelfController.shelfBooks[index].isbn);
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
                                                 child: Image.network(shelfController.shelfBooks[index].image, fit: BoxFit.fitWidth, width: 50,)),
                                             const Spacer(
                                               flex: 1,
                                             ),
                                             Expanded(
                                               flex: 11,
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.end,
                                                 children: [
                                                       Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           Row(
                                                             crossAxisAlignment: CrossAxisAlignment.center,
                                                             children:[Icon(Icons.circle, color: bookColor[shelfController.shelfBooks[index].bookState == "읽고싶은" ? 0 : shelfController.shelfBooks[index].bookState == '읽는중인' ? 1 : 2] ,),
                                                             Text('${shelfController.shelfBooks[index].bookState}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200, fontFamily: 'Pretendard'),)]
                                                           ),
                                                           Padding(padding: EdgeInsets.only(bottom: 10)),
                                                           Text('${shelfController.shelfBooks[index].title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                                           Text('${shelfController.shelfBooks[index].author}', style: TextStyle(fontSize: 14, fontFamily: 'Pretendard'),)
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
                     //읽고 싶은
                     NotificationListener(
                       onNotification: (OverscrollIndicatorNotification overscroll) {
                         overscroll.disallowIndicator();
                         return true;
                       },
                       child: ListView.builder(
                         itemCount: shelfController.shelfBooks.where((p0) => p0.bookState == '읽고싶은').toList().length,
                         itemBuilder: (context, index){
                           return GestureDetector(
                             onTap: (){
                               Get.to(
                                       () => ChangeNotifierProvider(
                                       create: (_) => BookProvider(),
                                       child: BookDetailView()),
                                   arguments: shelfController.shelfBooks[index].isbn);
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
                                         child: Image.network(shelfController.shelfBooks.where((p0) => p0.bookState == '읽고싶은').toList()[index].image, fit: BoxFit.fitWidth, width: 50,)),
                                     const Spacer(
                                       flex: 1,
                                     ),
                                     Expanded(
                                       flex: 11,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children:[Icon(Icons.circle, color: bookColor[0],),
                                                     Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽고싶은').toList()[index].bookState, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200, fontFamily: 'Pretendard'),)]
                                               ),
                                               Padding(padding: EdgeInsets.only(bottom: 10)),
                                               Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽고싶은').toList()[index].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                               Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽고싶은').toList()[index].author, style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
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
                     //읽고 있는
                     NotificationListener(
                       onNotification: (OverscrollIndicatorNotification overscroll) {
                         overscroll.disallowIndicator();
                         return true;
                       },
                       child: ListView.builder(
                         itemCount: shelfController.shelfBooks.where((p0) => p0.bookState == '읽는중인').toList().length,
                         itemBuilder: (context, index){
                           return GestureDetector(
                             onTap: (){
                               Get.to(
                                       () => ChangeNotifierProvider(
                                       create: (_) => BookProvider(),
                                       child: BookDetailView()),
                                   arguments: shelfController.shelfBooks[index].isbn);
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
                                         child: Image.network(shelfController.shelfBooks.where((p0) => p0.bookState == '읽는중인').toList()[index].image, fit: BoxFit.fitWidth, width: 50,)),
                                     const Spacer(
                                       flex: 1,
                                     ),
                                     Expanded(
                                       flex: 11,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children:[Icon(Icons.circle, color: bookColor[1],),
                                                     Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽는중인').toList()[index].bookState, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200, fontFamily: 'Pretendard'),)]
                                               ),
                                               const Padding(padding: EdgeInsets.only(bottom: 10)),
                                               Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽는중인').toList()[index].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                               Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽는중인').toList()[index].author, style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
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
                     //읽은
                     NotificationListener(
                       onNotification: (OverscrollIndicatorNotification overscroll) {
                         overscroll.disallowIndicator();
                         return true;
                       },
                       child: ListView.builder(
                         itemCount: shelfController.shelfBooks.where((p0) => p0.bookState == '읽은').toList().length,
                         itemBuilder: (context, index){
                           return GestureDetector(
                             onTap: (){
                               Get.to(
                                       () => ChangeNotifierProvider(
                                       create: (_) => BookProvider(),
                                       child: BookDetailView()),
                                   arguments: shelfController.shelfBooks[index].isbn);
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
                                         child: Image.network(shelfController.shelfBooks.where((p0) => p0.bookState == '읽은').toList()[index].image, fit: BoxFit.fitWidth, width: 50,)),
                                     const Spacer(
                                       flex: 1,
                                     ),
                                     Expanded(
                                       flex: 11,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children:[Icon(Icons.circle, color: bookColor[2],),
                                                     Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽은').toList()[index].bookState, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200, fontFamily: 'Pretendard'),)]
                                               ),
                                               Padding(padding: EdgeInsets.only(bottom: 10)),
                                               Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽은').toList()[index].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                               Text(shelfController.shelfBooks.where((p0) => p0.bookState == '읽은').toList()[index].author, style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
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
             }
           ),
         ),
       ],
     );
  }

  Padding SearchLibrary() {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(16))
          ),
          child: TextField(
            focusNode: _focusNode,
            cursorColor: appColor.shade800,
            keyboardType: TextInputType.text,
            onTap: (){
              Get.to(LibrarySearchView());
            },
            decoration: InputDecoration(
              //검색바 클릭 전 border
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                    color: appColor.shade700,
                    width: 1.2
                ),
              ),
              //검색바 클릭시 아래 border 출력
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                    color: appColor.shade700,
                    width: 1.2
                ),
              ),
              contentPadding: const EdgeInsets.only(left: 15, top: 16),
              hintText: '서재 내 도서 검색',
              hintStyle: TextStyle(color: appColor.shade800),
              // homeContent 화면으로의 back을 위한 아이콘
              // 검색 아이콘
              suffixIcon: Icon(Icons.search, color: appColor.shade900),
            ),
            textInputAction: TextInputAction.search,
          ),
        )
    );
  }

  // //bookdata fetch 를 위한...
  // Future<List<Map<String, dynamic>>> _fetchData() async {
  //   http.Client client = http.Client();
  //
  //   final response = await client.get(Uri.parse(server + '/bookshelf/allbooks'),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer ${loginController.idToken}'
  //       });
  //   var data = jsonDecode(utf8.decode(response.bodyBytes));
  //
  //   List<dynamic> listData = data;
  //   List<Map<String, dynamic>> mappedData = listData.map((item) => item as Map<String, dynamic>).toList();
  //
  //   return mappedData;
  // }
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


