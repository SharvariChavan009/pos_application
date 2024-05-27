import 'package:flutter/material.dart';

enum PaymentType { cash, online }

class CustomRadioButton extends StatefulWidget {
  final ValueChanged<PaymentType?> onChanged;

  const CustomRadioButton({super.key, required this.onChanged});

  @override
  State<CustomRadioButton> createState() => CustomRadioButtonState();
}

class CustomRadioButtonState extends State<CustomRadioButton> {
  PaymentType? _character = PaymentType.cash;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Cash'),
              leading: Radio<PaymentType>(
                value: PaymentType.cash,
                groupValue: _character,
                onChanged: (PaymentType? value) {
                  setState(() {
                    _character = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
            ListTile(
              title: const Text('Online'),
              leading: Radio<PaymentType>(
                value: PaymentType.online,
                groupValue: _character,
                onChanged: (PaymentType? value) {
                  setState(() {
                    _character = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          ],
        ));
  }
}
