import 'package:coder_fair/constants/app_colors.dart';
import 'package:flutter/material.dart';

List dates = [
  "6/6/22 - 6/9/22",
  "6/13/22 - 6/17/22",
  "6/20/22 - 6/24/22",
  "6/27/22 - 7/1/22",
  "7/4/22 - 7/8/22",
  "7/11/22 - 7/15/22",
  "7/18/22 - 7/22/22",
  "7/25/22 - 7/29/22",
  "8/1/22 - 8/5/22",
];

class CustomSchedule extends StatelessWidget {
  CustomSchedule({
    Key? key,
  }) : super(key: key);

  final ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          TextStyle(fontFamily: 'Raleway', color: AppColor.white, fontSize: 16),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Roblox:",
            style: TextStyle(
                fontFamily: 'Raleway', color: AppColor.white, fontSize: 20),
          ),
          CustomExpansion(
            title: "Roblox Metaverse Modeling",
            southTampa: [0, 6],
            newTampa: [0, 3],
            carrollwood: [3, 6],
          ),
          CustomExpansion(
            title: "Roblox Metaverse Coding",
            southTampa: [1, 7],
            newTampa: [1, 4],
            carrollwood: [4, 7],
          ),
          CustomExpansion(
            title: "Building a Roblox Metaverse",
            southTampa: [2, 8],
            newTampa: [2, 5],
            carrollwood: [5, 8],
          ),
          Divider(
            color: AppColor.white,
            height: 20,
          ),
          Text(
            "Minecraft:",
            style: TextStyle(
                fontFamily: 'Raleway', color: AppColor.white, fontSize: 20),
          ),
          CustomExpansion(
            title: "Minecraft Metaverse Modeling",
            southTampa: [3],
            newTampa: [6],
            carrollwood: [0],
          ),
          CustomExpansion(
            title: "Micraft Metaverse Coding",
            southTampa: [4],
            newTampa: [7],
            carrollwood: [1],
          ),
          CustomExpansion(
            title: "Building a Minecraft Metaverse",
            southTampa: [5],
            newTampa: [8],
            carrollwood: [2],
          ),
        ],
      )),
    );
  }
}

class CustomExpansion extends StatelessWidget {
  const CustomExpansion({
    Key? key,
    required this.title,
    required this.southTampa,
    required this.newTampa,
    required this.carrollwood,
  }) : super(key: key);
  final String title;
  final List<int> southTampa;
  final List<int> newTampa;
  final List<int> carrollwood;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          TextStyle(fontFamily: 'Raleway', color: AppColor.white, fontSize: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ExpansionTile(
            textColor: AppColor.accentGreen,
            collapsedTextColor: AppColor.white,
            iconColor: AppColor.accentGreen,
            collapsedIconColor: AppColor.white,
            collapsedBackgroundColor: AppColor.black,
            backgroundColor: AppColor.black,
            title: Text("$title",
                style: TextStyle(
                  fontFamily: 'Raleway',
                )),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.darkGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ExpansionTile(
                  textColor: AppColor.accentPurple,
                  collapsedTextColor: AppColor.white,
                  iconColor: AppColor.accentPurple,
                  collapsedIconColor: AppColor.white,
                  expandedAlignment: Alignment.centerLeft,
                  title: Text("South Tampa",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16)),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🗓 Dates Available:\n"),
                          ...this
                              .southTampa
                              .map((e) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Text("· ${dates[e]}"),
                                  ))
                              .toList()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.darkGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ExpansionTile(
                  textColor: AppColor.accentPurple,
                  collapsedTextColor: AppColor.white,
                  iconColor: AppColor.accentPurple,
                  collapsedIconColor: AppColor.white,
                  expandedAlignment: Alignment.centerLeft,
                  title: Text("New Tampa",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16)),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🗓 Dates Available:\n"),
                          ...this
                              .newTampa
                              .map((e) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Text("· ${dates[e]}"),
                                  ))
                              .toList()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.darkGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ExpansionTile(
                  textColor: AppColor.accentPurple,
                  collapsedTextColor: AppColor.white,
                  iconColor: AppColor.accentPurple,
                  collapsedIconColor: AppColor.white,
                  title: Text("Carrollwood",
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16)),
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🗓 Dates Available:\n"),
                          ...this
                              .carrollwood
                              .map((e) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Text("· ${dates[e]}"),
                                  ))
                              .toList()
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
