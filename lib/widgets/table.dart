import 'package:coder_fair/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSchedule extends StatelessWidget {
  CustomSchedule({
    Key? key,
  }) : super(key: key);

  final ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: ThemeData(
            scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: true,
          thumbColor: MaterialStateProperty.all(AppColor.accentPurple),
          trackBorderColor: MaterialStateProperty.all(Colors.transparent),
          trackColor: MaterialStateProperty.all(AppColor.lightGrey),
        )),
        child: Scrollbar(
            controller: sc,
            showTrackOnHover: true,
            isAlwaysShown: true,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                SingleChildScrollView(
                  controller: sc,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      dataTextStyle: TextStyle(
                          color: AppColor.white, fontFamily: 'Raleway'),
                      // Adjusts the lines
                      headingRowHeight: 30,
                      columnSpacing: 30,
                      dataRowHeight: 70,
                      columns: <DataColumn>[
                        DataColumn(
                            label: Text(
                          'Camp',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '6/6-9',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '6/13-17',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '6/20-24',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '6/27-7/1',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '7/4-8',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '7/11-15',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '7/18-22',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '7/25-29',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                        DataColumn(
                            label: Text(
                          '8/1-5',
                          style: TextStyle(
                              color: AppColor.buttonGreen,
                              fontFamily: 'Raleway'),
                        )),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Roblox Metaverse Modeling',
                            )),
                            DataCell(Text(
                              'NT, ST',
                            )),
                            DataCell(Text(
                              '',
                            )),
                            DataCell(Text(
                              '',
                            )),
                            DataCell(Text(
                              'NT, CW',
                            )),
                            DataCell(Text(
                              '',
                            )),
                            DataCell(Text(
                              '',
                            )),
                            DataCell(Text(
                              'ST, CW',
                            )),
                            DataCell(Text(
                              '',
                            )),
                            DataCell(Text(
                              '',
                            )),
                          ],
                        ), // end of first row
                        DataRow(cells: [
                          //roblox 2
                          DataCell(Text('Roblox Metaverse Coding')),
                          DataCell(Text('')),
                          DataCell(Text('NT, ST')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('NT, CW')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('ST, CW')),
                          DataCell(Text('')),
                        ]),

                        DataRow(cells: [
                          //roblox 3
                          DataCell(Text('Building a Roblox Metaverse')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('NT, ST')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('NT, CW')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('ST, CW')),
                        ]),
                        DataRow(cells: [
                          // empty
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          // Minecraft 1
                          DataCell(Text('Minecraft Metaverse Modeling')),
                          DataCell(Text('CW')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('ST')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('NT')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          // Minecraft 2
                          DataCell(Text('Minecraft Metaverse Coding')),
                          DataCell(Text('')),
                          DataCell(Text('CW')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('ST')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('NT')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          // Minecraft 3
                          DataCell(Text('Building a Minecraft Metaverse')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('CW')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('ST')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('NT')),
                        ]),
                      ]),
                ),
                Container(
                  color: AppColor.black,
                  width: 100,
                  // height: 400,
                  child: Center(
                    child: DataTable(
                        headingRowHeight: 50,
                        dataRowHeight: 70,
                        dataTextStyle: TextStyle(
                            color: AppColor.white, fontFamily: 'Raleway'),
                        // Adjusts the lines
                        columnSpacing: 30,
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text(
                            'Camp',
                            style: TextStyle(
                                color: AppColor.buttonGreen,
                                fontFamily: 'Raleway'),
                          )),
                        ],
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                'Roblox Metaverse Modeling',
                              )),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                'Roblox Metaverse Coding',
                              )),
                            ],
                          ), // end of first row
                          DataRow(cells: [
                            //roblox 2
                            DataCell(Text('Building a Roblox Metaverse')),
                          ]),

                          DataRow(cells: [
                            //roblox 3
                            DataCell(Text('')),
                          ]),
                          DataRow(cells: [
                            // Minecraft 1
                            DataCell(Text('Minecraft Metaverse Modeling')),
                          ]),
                          DataRow(cells: [
                            // Minecraft 2
                            DataCell(Text('Minecraft Metaverse Coding')),
                          ]),
                          DataRow(cells: [
                            // Minecraft 3
                            DataCell(Text('Building a Minecraft Metaverse')),
                          ]),
                        ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
