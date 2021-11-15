import 'package:covidproject/models/covid_world.dart';
import 'package:covidproject/providers/covid.api.dart';
import 'package:covidproject/screens/link_details_screen.dart';
import 'package:covidproject/values/page_content.dart';
import 'package:covidproject/values/page_indicator.dart';
import 'package:covidproject/widgets/category_item.dart';
import 'package:flutter/material.dart';
import '../models/covid.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final color =
  //     Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  List<Covid>? _covid;
  List<CovidWorld>? _covidWorld;

  bool? _isLoading = true;

  @override
  void initState() {
    super.initState();
    getCovids();
    getCovidWorld();
  }

  Future<void> getCovidWorld() async {
    _covidWorld = await CovidApi.getCovidWorld();
    //print(_covidWorld);
  }

  Future<void> getCovids() async {
    _covid = await CovidApi.getCovid();
    setState(() {
      _isLoading = false;
    });
  }

  PageController? _pageController;
  int? currentPage;
  void onPageChanged(int i) {
    setState(() {
      currentPage = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 310,
                    height: 140,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 310,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xffe9f4f3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(-0.87, 1),
                          child: Container(
                            child: Hero(
                                tag: "hero",
                                child: Image.asset(
                                  'assets/images/logo.png',
                                )),
                          ),
                        ),
                        Container(
                          child: PageView.builder(
                            scrollDirection: Axis.vertical,
                            controller: _pageController,
                            itemCount: pageContentList.length,
                            onPageChanged: (int i) {
                              onPageChanged(i);
                            },
                            itemBuilder: (BuildContext ctx, int i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      LinkDetailsScreen.routename,
                                      arguments: pageContentList[i]);
                                },
                                child: Align(
                                  alignment: const Alignment(0.5, 0.3),
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff057163),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: pageContentList[i].pageHeading,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        const TextSpan(text: "\n\n"),
                                        const TextSpan(
                                            text: "Read More",
                                            style: TextStyle(
                                                fontSize: 13,
                                                decoration:
                                                    TextDecoration.underline))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.85, 0.3),
                          child: PageIndicator(
                            indicatorCount: pageContentList.length,
                            currentIndex: currentPage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Information World'),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   child: GridView.builder(
                  //       gridDelegate:
                  //           const SliverGridDelegateWithMaxCrossAxisExtent(
                  //               maxCrossAxisExtent: 200,
                  //               childAspectRatio: 3 / 2,
                  //               crossAxisSpacing: 20,
                  //               mainAxisSpacing: 20),
                  //       itemBuilder: (BuildContext ctx, index) {
                  //         return CategoryItem(
                  //           _covidWorld![index].newCases,
                  //           _covidWorld![index].totalCases,
                  //         );
                  //       }),
                  // ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 350,
                    child: _isLoading!
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: _covid!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return CategoryItem(
                                _covid![index].countryName,
                                _covid![index].deaths,
                              );
                            }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
