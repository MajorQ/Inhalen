import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/settings_model.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// TODO: make ViewModel!!!!
class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  final _labelKey = GlobalKey<FormState>();
  TextEditingController _controller;
  double _containerWidth = 75;
  double _containerHeight = 50;
  double _container2Width = 150;
  double _container2Height = 100;
  bool showDone = false;

  void _onIntroEnd(context) {
    var settingsModel = Provider.of<SettingsModel>(context, listen: false);
    settingsModel.newlyInstalled = false;
    settingsModel.name = _controller.text;
    if (showDone) {
      Navigator.pushReplacementNamed(context, '/screen');
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontFamily: 'OpenSans', fontSize: 19.0);
    const titleStyle = TextStyle(
        fontFamily: 'Raleway', fontSize: 28.0, fontWeight: FontWeight.w700);
    const pageDecoration = const PageDecoration(
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
            title: 'Welcome to the\nInhalen Application',
            body: '',
            image: Padding(
              padding: const EdgeInsets.only(top: 36.0, bottom: 24.0),
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.contain,
              ),
            ),
            decoration: pageDecoration),
        PageViewModel(
          titleWidget: Padding(
            padding: const EdgeInsets.only(top: 54.0),
            child: Text(
              'onboarding.language',
              textAlign: TextAlign.center,
              style: titleStyle,
            ).tr(),
          ),
          bodyWidget:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
              onPressed: () {
                context.locale = Locale('id');
                _containerWidth = 150;
                _containerHeight = 100;
                _container2Width = 75;
                _container2Height = 50;
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    height: _containerHeight,
                    width: _containerWidth,
                    child: Image.asset(
                      'assets/images/indonesia.png',
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Bahasa\nIndonesia',
                      textAlign: TextAlign.center, style: bodyStyle),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                context.locale = Locale('en');
                _containerWidth = 75;
                _containerHeight = 50;
                _container2Width = 150;
                _container2Height = 100;
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    height: _container2Height,
                    width: _container2Width,
                    child: Image.asset(
                      'assets/images/usa.png',
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('English-US', style: bodyStyle),
                ],
              ),
            ),
          ]),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'onboarding.study'.tr(),
          body: 'onboarding.study_body'.tr(),
          image: Image.asset('assets/images/onboarding_learn.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'onboarding.reminder'.tr(),
          body: 'onboarding.reminder_body'.tr(),
          image: Image.asset('assets/images/onboarding_reminder.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Padding(
            padding: const EdgeInsets.only(top: 54.0),
            child: Text(
              'onboarding.start'.tr(),
              style: titleStyle,
            ),
          ),
          body: 'onboarding.your_name'.tr(),
          footer: Consumer<SettingsModel>(builder: (context, settingsModel, _) {
            return Form(
              key: _labelKey,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: 'name'.tr(),
                    focusColor: CustomColors.blue,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontStyle: FontStyle.normal,
                    ),
                    errorStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)),
                maxLength: 12,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (String value) {
                  if (_labelKey.currentState.validate()) {
                    setState(() {
                      if (value == '') {
                        showDone = false;
                      } else {
                        showDone = true;
                      }
                    });
                  }
                },
                validator: (String value) {
                  if (value.length > 12) {
                    return 'name_input_validator'.tr();
                  }
                  return null;
                },
              ),
            );
          }),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'skip',
        style: TextStyle(
          fontSize: 18,
        ),
      ).tr(),
      next:
          const Icon(Icons.arrow_forward, size: 44, color: CustomColors.maroon),
      done: Text('done',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                  color: (showDone) ? CustomColors.maroon : Colors.grey))
          .tr(),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeSize: Size(22.0, 10.0),
        activeColor: CustomColors.maroon,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
