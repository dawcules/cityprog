import 'package:cityprog/model/carpool.dart';
import 'package:cityprog/model/trade_methods.dart';
import 'package:cityprog/validation/origin_destination_validator.dart';
import 'package:cityprog/widgets/buttons/submit_form_button.dart';
import 'package:cityprog/widgets/carpool_marketplace/forms/custom_expansion_tile.dart';
import 'package:cityprog/widgets/columns/origin_destination.dart';
import 'package:cityprog/widgets/columns/title_details_column.dart';
import 'package:cityprog/widgets/rows/text_date_with_calendar.dart';
import 'package:cityprog/widgets/rows/time_picker.dart';
import 'package:flutter/material.dart';

class CarpoolForm extends StatefulWidget {
  final Trading method;
  CarpoolForm(this.method);

  @override
  _CarpoolFormState createState() => _CarpoolFormState();
}

class _CarpoolFormState extends State<CarpoolForm> {
  bool _dateWasPicked = false;
  bool _timeWasPicked = false;
  bool _dateNeedsToReDraw = false;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  String _destination;
  String _origin;
  String _title;
  String _body;
  // TODO: dateNeedsToReDraw implementation, Pakolliset, Lisätietoja etc. joo lisää vaan
  OriginDestinationValidator validator;

  @override
  void initState() {
    super.initState();
    validator = OriginDestinationValidator();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CustomExpansionTile(
            leading: Icon(Icons.notification_important),
            initiallyExpanded: true,
            title: Text("Pakolliset"),
            children: <Widget>[
              OriginDestinationColumn(
                onDestinationPicked: (String address) =>
                    _onDestinationPicked(address),
                onOriginPicked: (String address) => _onOriginPicked(address),
              ),
              TextDateWithCalendarPicker(
                onDatePicked: (DateTime date) => _onDatePicked(date),
                alignment: MainAxisAlignment.end,
                textIsInstructions: !_dateWasPicked,
              ),
              TimePicker(
                onTimePicked: (TimeOfDay time) => _onTimePicked(time),
                showInstructions: !_timeWasPicked,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          CustomExpansionTile(
            onExpansionChanged: (value) => print(value),
            leading: Icon(Icons.more),
            title: Text("Lisätietoja"),
            children: <Widget>[
              TitleDetailsColumn(),
            ],
          ),
          SubmitFormButton(
            onPress: _validate,
            onValidatedSuccess: () => _submitPost(),
          )
        ],
      ),
    );
  }

  void _onDatePicked(DateTime date) {
    print("Date: $date picked");
    _selectedDate = date;
    if (!_dateWasPicked) {
      setState(() => _dateWasPicked = true);
    }
  }

  void _onTimePicked(TimeOfDay time) {
    print(time);
    _selectedTime = time;
    if (!_timeWasPicked) {
      setState(() {
        _timeWasPicked = true;
      });
    }
  }

  void _onDestinationPicked(String address) {
    validator.destinationSelected = true;
    print(address);
    _destination = address;
  }

  void _onOriginPicked(String address) {
    validator.originSelected = true;
    print(address);
    _origin = address;
  }

  void _validate(Function callback) {
    callback(validator.validate() && _timeWasPicked && _dateWasPicked);
  }

  _submitPost() {
    print("asking submitted");
    CarpoolPostData post = CarpoolPostData(
      body: _body,
      title: _title,
      from: _origin,
      postDate: DateTime.now(),
      to: _destination,
      timeOfDay: _selectedTime,
      date: _selectedDate,
    );
  }
}