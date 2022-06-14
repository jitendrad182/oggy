import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oggy/const/color_const.dart';
import 'package:oggy/main.dart';
import 'package:oggy/services/data/api.dart';
import 'package:oggy/utils/app_sizes.dart';
import 'package:oggy/views/dialogs/dialogs.dart';
import 'package:oggy/views/widgets/custom_buttons/custom_button_1.dart';
import 'package:oggy/views/widgets/custom_drawer/custom_drawer_1.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Api _api = Get.find();

  @override
  Widget build(BuildContext context) {
    AppSizes.mediaQueryHeightWidth();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
          statusBarColor: ColorConst.primaryColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: [
          TextButton(
            onPressed: () {
              showModalBottomSheet<dynamic>(
                  context: context,
                  builder: (_) {
                    return SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _api.cities?.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      CustomButton1(
                                        text: '${_api.cities?[index].name}',
                                        buttonColor: ColorConst.primaryColor,
                                        textColor: ColorConst.blackColor,
                                        onTap: () {
                                          navigatorKey.currentState!.pop();
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: ColorConst.whiteColor,
                ),
                Text(
                  ' ${_api.defCityName} ',
                  style: TextStyle(
                    color: ColorConst.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.width10 * 1.7,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer1(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _api.localities?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CustomButton1(
                        text: '${_api.localities?[index].title}',
                        buttonColor: ColorConst.blueGreyColor,
                        textColor: ColorConst.blackColor,
                        onTap: () async {
                          Dialogs.circularProgressIndicatorDialog(context);
                          _api.defLocalityName = _api.localities?[index].title;
                          await _api.getRestaurants(
                              _api.defCityId, _api.localities?[index].id);
                          navigatorKey.currentState!.pop();
                          Get.to(() => HomePage2());
                        },
                      ),
                      const SizedBox(height: 10)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  HomePage2({Key? key}) : super(key: key);

  final Api _api = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
          statusBarColor: ColorConst.primaryColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: [
          Row(
            children: [
              const Icon(
                Icons.location_city,
                color: ColorConst.whiteColor,
              ),
              Text(
                ' ${_api.defLocalityName} ',
                style: TextStyle(
                  color: ColorConst.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.width10 * 1.7,
                ),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _api.restaurants!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ColorConst.whiteColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConst.greyColor.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                _api.restaurants?[index].orgImg != ''
                                    ? "${_api.restaurants?[index].orgImg}"
                                    : _api.defImage,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_api.restaurants?[index].name}',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '${_api.restaurants?[index].locality}, ${_api.restaurants?[index].city}',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      _api.restaurants?[index].rating != ''
                                          ? '${_api.restaurants?[index].rating} ★'
                                          : '-',
                                      style: const TextStyle(
                                          color: ColorConst.whiteColor),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _api.defIndex = index;
                          Get.to(() => HomePage3());
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage3 extends StatelessWidget {
  HomePage3({Key? key}) : super(key: key);

  final Api _api = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
          statusBarColor: ColorConst.primaryColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.network(
              _api.restaurants?[_api.defIndex].orgImg != ''
                  ? '${_api.restaurants?[_api.defIndex].orgImg}'
                  : _api.defImage,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_api.restaurants?[_api.defIndex].name}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          softWrap: false,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${_api.restaurants?[_api.defIndex].cuisines}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${_api.restaurants?[_api.defIndex].locality}, ${_api.restaurants?[_api.defIndex].city}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      _api.restaurants?[_api.defIndex].rating != ''
                          ? '${_api.restaurants?[_api.defIndex].rating} ★'
                          : '-',
                      style: const TextStyle(color: ColorConst.whiteColor),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton1(
                    text: '➥ Direction',
                    buttonColor: ColorConst.primaryColor,
                    textColor: ColorConst.whiteColor,
                    onTap: () {
                      MapUtils.launchMapsUrl(
                          _api.restaurants?[_api.defIndex].latitude,
                          _api.restaurants?[_api.defIndex].longitude);
                    },
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Online Offers',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Offers and Coupons verified today',
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  _api.restaurants?[_api.defIndex].offers[0].title != null
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorConst.primaryColor,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Online Offers',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${_api.restaurants?[_api.defIndex].offers[0].title}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                _api.restaurants?[_api.defIndex].offers[0]
                                            .code !=
                                        ''
                                    ? CustomButton1(
                                        text:
                                            '${_api.restaurants?[_api.defIndex].offers[0].code}',
                                        buttonColor: ColorConst.blueGreyColor,
                                        textColor: ColorConst.whiteColor,
                                        onTap: () {},
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        )
                      : Center(),
                  SizedBox(height: 10),
                  _api.restaurants?[_api.defIndex].offers[1].title != null
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorConst.primaryColor,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Online Offers',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${_api.restaurants?[_api.defIndex].offers[1].title}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                _api.restaurants?[_api.defIndex].offers[1]
                                            .code !=
                                        ''
                                    ? CustomButton1(
                                        text:
                                            '${_api.restaurants?[_api.defIndex].offers[1].code}',
                                        buttonColor: ColorConst.blueGreyColor,
                                        textColor: ColorConst.whiteColor,
                                        onTap: () {},
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        )
                      : Center()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
