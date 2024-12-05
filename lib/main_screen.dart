// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_app/Model/currency.dart';
import 'package:online_app/myColors.dart';
import 'package:http/http.dart' as httpme;
import 'dart:convert' as convertme;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Currency> myCurrency = [];

  Future getResponse() async {
    var urlCustom =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var myValue = await httpme.get(Uri.parse(urlCustom));
    if (myValue.statusCode == 200) {
      print((myValue.statusCode));
      List myJson = convertme.jsonDecode(myValue.body);
      if (myCurrency.isEmpty) {
        if (myJson.isNotEmpty) {
          for (int s = 0; s < myJson.length; s++) {
            setState(() {
              myCurrency.add(
                Currency(
                  changes: myJson[s]['changes'],
                  id: myJson[s]['id'],
                  title: myJson[s]['title'],
                  price: myJson[s]['price'],
                  status: myJson[s]['status'],
                ),
              );
            });
          }
        }
      }
    }
  }

  // getResponse() {
  //   var url =
  //       'https://sasansafari.com/flutter/api.php?access_key=flutter123456';
  //   httpme.get(Uri.parse(url)).then((value) {
  //     if (value.statusCode == 200) {
  //       List dataJsonList = convertme.jsonDecode(value.body);
  //       if (myCurrency.isEmpty) {
  //         if (dataJsonList.isNotEmpty) {
  //           for (int i = 0; i < dataJsonList.length; i++) {
  //             setState(() {
  //               myCurrency.add(
  //                 Currency(
  //                   id: dataJsonList[i]['id'],
  //                   title: dataJsonList[i]['title'],
  //                   price: dataJsonList[i]['price'],
  //                   changes: dataJsonList[i]['changes'],
  //                   status: dataJsonList[i]['status'],
  //                 ),
  //               );
  //             });
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    getResponse();
    var textThemeCustom = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Mycolors.scaffoldBg,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            const SizedBox(
              width: 30,
            ),
            Image.asset('assets/icons/icon.png'),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'قیمت به روز ارز',
                style: textThemeCustom.headlineSmall,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 85,
                  child: Image.asset('assets/icons/2976215.png'),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/icons/752675.png'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'نرخ ارز آزاد چیست؟',
                    style: textThemeCustom.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Text(
                ' نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.',
                textDirection: TextDirection.rtl,
                style: textThemeCustom.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Container(
                height: 35,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Mycolors.containerColorHeader,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'نام آزاد ارز',
                        style: textThemeCustom.displayMedium,
                      ),
                      Text(
                        'قیمت',
                        style: textThemeCustom.displayMedium,
                      ),
                      Text(
                        'تغییر',
                        style: textThemeCustom.displayMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: myCurrency.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int postion) {
                  return ItemList(
                    textThemeCustom: textThemeCustom,
                    position: postion,
                    myCurrency: myCurrency,
                  );
                },
                separatorBuilder: (context, index) {
                  if (index % 9 == 0) {
                    return _ItemListTab(textThemeCustom: textThemeCustom);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: Mycolors.containerColor2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 55,
                      child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Mycolors.buttonColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _showSnackBar(context, 'بروز رسانی انجام شد');
                        },
                        icon: const Icon(
                          CupertinoIcons.refresh_bold,
                          color: Colors.black,
                        ),
                        label: Text(
                          'بروز رسانی',
                          style: textThemeCustom.displaySmall,
                        ),
                      ),
                    ),
                    Text(
                      'آخرین بروزرسانی ${_getTime()}',
                      style: textThemeCustom.displaySmall,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getTime() {
    return '20:45';
  }
}

class ItemList extends StatelessWidget {
  int position;
  List<Currency> myCurrency = [];

  ItemList({
    super.key,
    required this.textThemeCustom,
    required this.position,
    required this.myCurrency,
  });

  final TextTheme textThemeCustom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: Mycolors.containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                myCurrency[position].title!,
                style: textThemeCustom.displaySmall,
              ),
              Text(
                myCurrency[position].price!,
                style: textThemeCustom.displaySmall,
              ),
              Text(
                myCurrency[position].changes!,
                style: myCurrency[position].status == "p"
                    ? textThemeCustom.bodyMedium
                    : textThemeCustom.bodyMedium!.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemListTab extends StatelessWidget {
  const _ItemListTab({
    required this.textThemeCustom,
  });

  final TextTheme textThemeCustom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تبلیغات',
                style: textThemeCustom.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Colors.purpleAccent,
    ),
  );
}
