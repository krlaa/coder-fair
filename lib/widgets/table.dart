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
                Positioned(
                  child: SingleChildScrollView(
                    controller: sc,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        dataTextStyle: TextStyle(
                            color: AppColor.white, fontFamily: 'Raleway'),
                        // Adjusts the lines
                        columnSpacing: 40,
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
                                'Roblox 1',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                              DataCell(Text(
                                'ST, NT',
                              )),
                            ],
                          ), // end of first row
                          DataRow(cells: [
                            //roblox 2
                            DataCell(Text('Roblox 2')),
                            DataCell(Text('ST, NT, CW')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                          ]),

                          DataRow(cells: [
                            //roblox 3
                            DataCell(Text('Roblox 3')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                          ]),
                          DataRow(cells: [
                            // Minecraft 1
                            DataCell(Text('Minecraft 1')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                          ]),
                          DataRow(cells: [
                            // Minecraft 2
                            DataCell(Text('Minecraft 2')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                          ]),
                          DataRow(cells: [
                            // Minecraft 3
                            DataCell(Text('Minecraft 3')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                            DataCell(Text('ST, NT')),
                          ]),
                        ]),
                  ),
                ),
                Container(
                  color: AppColor.black,
                  width: 125,
                  child: DataTable(
                      dataTextStyle: TextStyle(
                          color: AppColor.white, fontFamily: 'Raleway'),
                      // Adjusts the lines
                      columnSpacing: 60,
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
                              'Roblox 1',
                            )),
                          ],
                        ), // end of first row
                        DataRow(cells: [
                          //roblox 2
                          DataCell(Text('Roblox 2')),
                        ]),

                        DataRow(cells: [
                          //roblox 3
                          DataCell(Text('Roblox 3')),
                        ]),
                        DataRow(cells: [
                          // Minecraft 1
                          DataCell(Text('Minecraft 1')),
                        ]),
                        DataRow(cells: [
                          // Minecraft 2
                          DataCell(Text('Minecraft 2')),
                        ]),
                        DataRow(cells: [
                          // Minecraft 3
                          DataCell(Text('Minecraft 3')),
                        ]),
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
