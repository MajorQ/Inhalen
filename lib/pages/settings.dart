import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/services/settings_model.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

// TODO: figure out a way to make this stateless
class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _labelKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var reminderModel = Provider.of<ReminderModel>(context, listen: false);
    reminderModel.changeNotificationMsg('notification'.tr());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
            child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon:
                        Icon(Icons.info, size: 44, color: CustomColors.maroon),
                    onPressed: () {
                      Navigator.pushNamed(context, '/about_us');
                    })),
          ),
          Text('bottom_navbar_icons.settings',
                  style: Theme.of(context).textTheme.headline4)
              .tr(),
          SizedBox(
            height: 30,
          ),
          Consumer<SettingsModel>(builder: (context, settingsModel, child) {
            return GestureDetector(
              onTap: () async {
                String name = await _pickLabel(
                  context,
                  settingsModel.name,
                );
                settingsModel.name = name;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.person, size: 24),
                  ),
                  Text('name', style: Theme.of(context).textTheme.headline5)
                      .tr(),
                  Spacer(flex: 10),
                  Text(settingsModel.name,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.normal)),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey[700], size: 32),
                ],
              ),
            );
          }),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.language, size: 24),
              ),
              Text('language', style: Theme.of(context).textTheme.headline5)
                  .tr(),
              Spacer(flex: 10),
              DropdownButton<String>(
                  value: context.locale.languageCode,
                  icon:
                      Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
                  iconSize: 32,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.grey[700], fontWeight: FontWeight.normal),
                  items: [
                    DropdownMenuItem(value: 'id', child: Text('Indonesia')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                  onChanged: ((value) {
                    context.locale = Locale(value);
                  })),
            ],
          ),
        ],
      ),
    );
  }

  // TODO: make a dialog manager class to show dialogs without context
  Future<String> _pickLabel(BuildContext context, String initialText) async {
    String label;
    await showDialog(
        context: context,
        builder: (context) {
          /// Show text fields input
          return AlertDialog(
            backgroundColor: CustomColors.maroon,
            content: Form(
              key: _labelKey,
              child: TextFormField(
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelText: 'name_input'.tr(),
                  labelStyle: TextStyle(
                    fontFamily: 'Raleway',
                    fontStyle: FontStyle.normal,
                    color: Colors.white60,
                  ),
                  counterStyle: TextStyle(
                    fontFamily: 'Raleway',
                    fontStyle: FontStyle.normal,
                    color: Colors.white60,
                  ),
                  errorStyle: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Raleway',
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                maxLength: 12,
                keyboardType: TextInputType.name,
                onSaved: (String value) => label = value,
                validator: (String value) {
                  return value.length > 12 ? 'name_input_validator'.tr() : null;
                },
              ),
            ),

            /// Button to cancel or submit label
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'cancel'.tr(),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (_labelKey.currentState.validate()) {
                    _labelKey.currentState.save();
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        });
    return label;
  }
}
