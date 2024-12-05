import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_app/myColors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'نرخ ارز آزاد چیست؟',
                    style: textThemeCustom.bodyLarge,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Image.asset('assets/icons/752675.png'),
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
                        'تغییر',
                        style: textThemeCustom.displayMedium,
                      ),
                      Text(
                        'قیمت',
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
                itemCount: 20,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, postion) {
                  return _ItemList(textThemeCustom: textThemeCustom);
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

class _ItemList extends StatelessWidget {
  const _ItemList({
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
          color: Mycolors.containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'دلار',
                style: textThemeCustom.displaySmall,
              ),
              Text(
                '70000',
                style: textThemeCustom.displaySmall,
              ),
              Text(
                '-7',
                style: textThemeCustom.displaySmall,
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
