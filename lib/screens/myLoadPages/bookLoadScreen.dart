import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liveasy/Web/dashboard.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/screens.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:liveasy/models/biddingModel.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/responsive.dart';
import 'package:liveasy/screens/HelpScreen.dart';
import 'package:liveasy/screens/myLoadPages/selectDriverScreen.dart';
import 'package:liveasy/screens/myLoadPages/selectTruckScreen.dart';
import 'package:liveasy/widgets/HeadingTextWidgetBlue.dart';
import 'package:liveasy/widgets/buttons/backButtonWidget.dart';

// ignore: must_be_immutable
class BookLoadScreen extends StatefulWidget {
  List? truckModelList;
  List? driverModelList;
  LoadDetailsScreenModel loadDetailsScreenModel;
  BiddingModel? biddingModel;
  bool? directBooking;
  String? postLoadId;

  BookLoadScreen(
      {this.truckModelList,
      this.postLoadId,
      this.driverModelList,
      required this.loadDetailsScreenModel,
      this.biddingModel,
      required this.directBooking});

  @override
  _BookLoadScreenState createState() => _BookLoadScreenState();
}

class _BookLoadScreenState extends State<BookLoadScreen> {
  String? selectedTruck;
  String? selectedDriver;
  String? selectedDriverName;

  TransporterIdController transporterIdController = Get.find();

  late List? driverList = [];
  late List? truckList = [];

  MapUtil mapUtil = MapUtil();

  // getTruckList() async {
  //   // FutureGroup futureGroup = FutureGroup();
  //
  //   var a = mapUtil.getDevices(); ///////////////////////////
  //   // var b = mapUtil.getTraccarPositionforAll(); /////////////////////
  //   var devices = await a; /////////////////////
  //   // setState(() {
  //   //   truckList = devices;
  //   // });
  //   // truckList = devices;
  //   // var gpsDataAll = await b; ////////////////////
  //   truckList!.clear();
  //   // // devicelist.clear();
  //   for (var device in devices) {
  //     setState(() {
  //       truckList!.add(device.truckno);
  //       print(truckList);
  //       // devicelist.add(device);
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {
      var page = ModalRoute.of(context)!.settings.name;
      Get.to(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (kIsWeb && (Responsive.isDesktop(context)))
        ? Scaffold(
            backgroundColor: teamBar,
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: space_2),
                child: Column(
                  children: [
                    SizedBox(
                      height: space_4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()));
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        SizedBox(
                          width: space_5,
                        ),
                        Container(
                          child: Text(
                            'Indent Booking',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      padding: EdgeInsets.only(left: space_20, top: space_15),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: space_8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select A Truck",
                            style: GoogleFonts.montserrat(
                              fontWeight: mediumBoldWeight,
                              fontSize: 24,
                              color: const Color(0xFF152968),
                            ),
                          ),
                          SizedBox(
                            height: space_2,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen(
                                          selectedIndex:
                                              screens.indexOf(auctionScreen),
                                          index: 1000,
                                          visibleWidget: SelectTruckScreen(
                                            loadDetailsScreenModel:
                                                widget.loadDetailsScreenModel!,
                                            directBooking: true,
                                          ))));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: space_20,
                                bottom: space_2,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(radius_1 + 2),
                                border: Border.all(
                                  color: widgetBackGroundColor,
                                ),
                                color: widgetBackGroundColor,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: space_2),
                                    child: Text(
                                      'Enter or select a truck number',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: textLightColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                        right: space_2 - 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: const Color(0xFF152968),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(bottom: space_2, top: space_14),
                            child: Text(
                              "Select A Driver",
                              style: GoogleFonts.montserrat(
                                fontWeight: mediumBoldWeight,
                                fontSize: 24,
                                color: const Color(0xFF152968),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen(
                                          selectedIndex:
                                              screens.indexOf(auctionScreen),
                                          index: 1000,
                                          visibleWidget: SelectDriverScreen(
                                            loadDetailsScreenModel:
                                                widget.loadDetailsScreenModel!,
                                            directBooking: true,
                                          ))));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: space_20, bottom: space_2),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(radius_1 + 2),
                                border:
                                    Border.all(color: widgetBackGroundColor),
                                color: widgetBackGroundColor,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: space_2),
                                    child: Text(
                                      'Enter or select a driver',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: textLightColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                        right: space_2 - 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: const Color(0xFF152968),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: space_20, right: space_30),
                            padding: EdgeInsets.only(bottom: space_6 + 0.5),
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(radius_1)),
                                color: const Color(0xFF152968),
                                child: Container(
                                  color: const Color(0xFF152968),
                                  height: 50,
                                  width: 230,
                                  child: Center(
                                    child: Text(
                                      "Confirm",
                                      style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size_12,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: statusBarColor,
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: space_2),
                child: Column(
                  children: [
                    SizedBox(
                      height: space_4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BackButtonWidget(),
                        SizedBox(
                          width: space_2,
                        ),
                        HeadingTextWidgetBlue('enterBookingDetails'.tr),
                        SizedBox(
                          width: space_4,
                        ),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HelpScreen()),
                              );
                            },
                            icon: Icon(
                              Icons.headset_mic_outlined,
                              color: const Color(0xFF152968),
                            ),
                            label: Text(
                              "Help".tr,
                              style: TextStyle(
                                  color: const Color(0xFF152968),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: space_5, top: space_15),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: space_2),
                      child: Text(
                        "Select Truck",
                        style: TextStyle(
                            fontSize: size_9,
                            fontWeight: mediumBoldWeight,
                            color: const Color(0xFF152968)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return SelectTruckScreen(
                            loadDetailsScreenModel:
                                widget.loadDetailsScreenModel!,
                            directBooking: true,
                          );
                        })));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: space_5, right: space_5, bottom: space_2),
                        height: 50,
                        width: 356,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius_1 + 2),
                            border: Border.all(color: const Color(0xFF152968))),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: space_2 - 2,
                              right: space_2 - 2,
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: white,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: const Color(0xFF152968),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: space_5, top: space_14),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: space_2),
                      child: Text(
                        "Select Driver",
                        style: TextStyle(
                            fontSize: size_9,
                            fontWeight: mediumBoldWeight,
                            color: const Color(0xFF152968)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return SelectDriverScreen(
                            loadDetailsScreenModel:
                                widget.loadDetailsScreenModel!,
                            directBooking: true,
                          );
                        })));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: space_5, right: space_5, bottom: space_2),
                        height: 50,
                        width: 356,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius_1 + 2),
                            border: Border.all(color: const Color(0xFF152968))),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: space_2 - 2,
                              right: space_2 - 2,
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: white,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: const Color(0xFF152968),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: space_6 + 0.5),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius_2)),
                            color: const Color(0xFF152968),
                            child: Container(
                              color: const Color(0xFF152968),
                              height: 54,
                              width: 242,
                              child: Center(
                                child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size_12,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
