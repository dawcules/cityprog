import 'package:auto_size_text/auto_size_text.dart';
import 'package:cityprog/strings/localized_report_strings.dart';
import 'package:cityprog/strings/validation_strings.dart';
import 'package:flutter/material.dart';
import 'package:cityprog/strings/dummy_address.dart';

class AddressPicker extends StatefulWidget {
  final String hintText;
  final Function onAddressPicked;
  const AddressPicker({this.hintText, this.onAddressPicked});

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  String _selectedAddress;

  @override
  void initState() {
    super.initState();
    _selectedAddress = widget.hintText == null
        ? LocalizedReportStrings.selectAddressToLocalized()
        : widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: DropdownButtonFormField<String>(
          autovalidate: true,
          isExpanded: true,
          hint: AutoSizeText(
            _selectedAddress,
            maxLines: 2,
            maxFontSize: 24,
            minFontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
          onChanged: (newValue) => setState(
            () => {
              _selectedAddress = newValue,
              if (widget.onAddressPicked != null) {
                widget.onAddressPicked(newValue)
              }
            }
          ),
          validator: (value) =>
              value == null ? ValidationStrings.mandatoryFieldToLocalized() : null,
          items: DummyAdress.all
              .map((String value) =>
                  DropdownMenuItem(child: Text(value), value: value))
              .toList(),
        ),
      ),
    );
  }
}
