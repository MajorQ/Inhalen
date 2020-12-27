import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/settings_model.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<FormState> _labelKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var settingsModel = Provider.of<SettingsModel>(context, listen: false);
    return Consumer<SettingsModel>(
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => _pickLabel(context, settingsModel),
                icon: Icon(Icons.edit, size: 40, color: CustomColors.maroon),
                label: Text(settingsModel.username,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 39.0,
                        color: CustomColors.maroon)),
              )
            ],
          ),
        );
      },
    );
  }

  _pickLabel(BuildContext context, SettingsModel model) async {
    showDialog(
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
                  labelText: 'Enter your name',
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
                maxLength: 15,
                keyboardType: TextInputType.name,
                onSaved: (String value) {
                  model.username = value;
                },
                validator: (String value) {
                  return value.length > 15
                      ? 'Username must be less\nthan 15 characters!'
                      : null;
                },
              ),
            ),

            /// Button to cancel or submit label
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
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
  }
}
