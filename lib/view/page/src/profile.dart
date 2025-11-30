//プロフィール画面　Navibar右下
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

    PageController _controller = PageController(viewportFraction: 0.4);
    double _currentPage = 0;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final collection_num = 255; //現在の図鑑登録数　後にDBから取得処理必要

    final List<Map<String, String>> items = [
      {
        "image": "https://picsum.photos/800/1400/",
        "name": "2023年",
      },
      {
        "image": "https://picsum.photos/800/1400/",
        "name": "2024年",
      },
      {
        "image": "https://picsum.photos/800/1400/",
        "name": "2025年",
      },
    ];

    @override
    void initState() {
      super.initState();
      _controller.addListener(() {
        setState(() {
          _currentPage = _controller.page!;
        });
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.20), // 高さを調整
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.06, left: width * 0.08, right: width * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'user_id',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.08, color: Color(0xFF1E2A54)),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.group_add_rounded),
                        iconSize: width * 0.07,
                        color: Color(0xFF1E2A54),
                        onPressed: () {}, //友達追加画面へ
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        iconSize: width * 0.07,
                        color: Color(0xFF1E2A54),
                        onPressed: () {}, //設定画面へ
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // アイコン、名前、生年月日ここからーーーーーーーーーーーーー
            Padding(
              padding: EdgeInsets.only(right: width * 0.10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: width * 0.08,
                    backgroundImage: NetworkImage("https://picsum.photos/200/"),
                  ),
                  Column(
                    children: [
                      Text("user_name", style: TextStyle(fontSize: width * 0.06)),
                      Text("2000/01/01", style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.08,)),
                    ],
                  )
                ]
              )
            ),
            // ーーーーーーーーーーーここまでーーーーーーーーーーーーー

            // 図鑑達成率ここからーーーーーーーーーーーーーーーーーーー
            Padding(
              padding: EdgeInsetsGeometry.only(top: height * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("図鑑達成率 " + collection_num.toString() + " / 366", style: TextStyle(fontSize: width * 0.05),),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: width * 0.20, right: width * 0.20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: LinearProgressIndicator(
                        value: collection_num / 366,
                        color: Colors.amber,
                        backgroundColor: Colors.grey[300],
                        minHeight: width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ーーーーーーーーーーーーここまでーーーーーーーーーーーー


            SizedBox(
              height: height * 0.45,
              child: PageView.builder(
                controller: _controller,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_controller.position.haveDimensions) {
                        value = _controller.page! - index;
                        value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
                      }
                      return Center(
                        child: Transform.scale(
                          scale: value,
                          child: GestureDetector(
                            onTap: () {
                              // タップされたときの処理 現在は仮処理
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${items[index]["name"]} がタップされました"),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 3 / 4,
                                      child: Image.network(
                                        items[index]["image"]!,
                                        // width: width * 1.0,
                                        // height: height * 0.25,
                                        fit: BoxFit.cover,
                                      ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    items[index]["name"]!,
                                    style: TextStyle(
                                      fontSize: 24 * value,
                                      color: Color(0xFF1E2A54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ),
                      );
                    },
                  );
                }
              )

            ),


            
            // SizedBox(
            //   height: 250,
            //   child: PageView.builder(
            //     controller: _controller,
            //     itemCount: images.length,
            //     itemBuilder: (context, index) {
            //       // 中央との差を計算（0 が中央）
            //       double distance = (_currentPage - index).abs();

            //       // scale を距離に応じて変化させる（最大 1.0、最小 0.6）
            //       double scale = 1.0 - (distance * 0.3);
            //       if (scale < 0.6) scale = 0.6;

            //       return Transform.scale(
            //         scale: scale,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8),
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(20),
            //             child: Image.network(
            //               images[index],
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),

          ],
        ),
        
      )
    );
  }
}
