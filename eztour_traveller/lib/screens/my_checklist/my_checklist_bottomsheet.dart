import 'package:eztour_traveller/constants.dart';
import 'package:flutter/material.dart';

class MyChecklistBottomSheet extends StatefulWidget {
  final Function(String) onSave;
  final String? initialMessage;

  const MyChecklistBottomSheet({
    Key? key,
    required this.onSave,
    this.initialMessage,
  }) : super(key: key);

  @override
  State<MyChecklistBottomSheet> createState() => _MyChecklistBottomSheetState();
}

class _MyChecklistBottomSheetState extends State<MyChecklistBottomSheet> {

  late String _value;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState((){
      _value = widget.initialMessage ?? '';
    });
    _controller.value = TextEditingValue(text: widget.initialMessage ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decoration = _value != '' ? const InputDecoration.collapsed(
        hintText: 'Your todo'
    ) : null;

    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: thinRoundedRectangleBorderRadius,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(defaultPadding),
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: thinRoundedRectangleBorderRadius,
                  ),
                  child: TextField(
                    decoration: decoration,
                    autofocus: true,
                    controller: _controller,
                    onChanged: (value){
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                      onPressed: () => widget.onSave(_value),
                    ),
                  ),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}