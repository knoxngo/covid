import 'package:covidproject/models/page_view_model.dart';
import 'package:covidproject/widgets/custom_back_button.dart';
import 'package:covidproject/widgets/detail_card.dart';
import 'package:flutter/material.dart';

class LinkDetailsScreen extends StatefulWidget {
  static const routename = 'link_details_screen';

  const LinkDetailsScreen({Key? key}) : super(key: key);

  @override
  _LinkDetailsScreenState createState() => _LinkDetailsScreenState();
}

class _LinkDetailsScreenState extends State<LinkDetailsScreen> {
  int tileIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageContent pageContent =
        ModalRoute.of(context)!.settings.arguments as PageContent;
    List<Widget> list = [];
    for (var i = 0; i < pageContent.content!.length; i++) {
      list.add(DetailCard(
        title: pageContent.content![i].title,
        details: pageContent.content![i].details,
        imagePath: pageContent.content![i].imagePath,
        isSelected: i == tileIndex ? true : false,
        onTap: () {
          setState(() {
            tileIndex = i;
          });
        },
      ));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: CustomBackButton(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pageContent.heading1!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          pageContent.heading2!,
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 250,
                          child: Text(
                            pageContent.heading3!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    Hero(
                      tag: 'hero',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: list,
              )
            ],
          ),
        ),
      ),
    );
  }
}
