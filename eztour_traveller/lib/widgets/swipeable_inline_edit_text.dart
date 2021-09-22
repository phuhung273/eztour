import 'package:eztour_traveller/mixins/swipeable.dart';
import 'package:eztour_traveller/widgets/inline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class SwipeableInlineEditText extends StatefulWidget{
  final String text;
  final void Function(String value) onEditingComplete;
  final void Function() onDelete;

  const SwipeableInlineEditText({
    required this.text,
    required this.onEditingComplete,
    required this.onDelete,
    required Key key,
  }) : super(key: key);

  @override
  _SwipeableInlineEditTextState createState() => _SwipeableInlineEditTextState();
}

class _SwipeableInlineEditTextState extends State<SwipeableInlineEditText> with Swipeable{

  late TextEditingController textEditingController;

  late String _text;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ValueKey(widget.key),
      backgroundColor: Colors.transparent,
      trailingActions: [
        SwipeAction(
          ///you should set the default  bg color to transparent
          color: Colors.transparent,

          ///set content instead of title of icon
          content: buildIconButton(Colors.red, Icons.delete),
          onTap: (handler) async {
            await handler(true);
            widget.onDelete();
          }
        ),
      ],
      child: Container(
        margin: const EdgeInsets.only(left: 36.0, top: 4.0),
        child: InlineTextField(
          text: _text,
          decoration: const InputDecoration(
            hintStyle: TextStyle(
              fontSize: 16.0,
              height: 1.1,
            ),
            border: InputBorder.none,
          ),
          onEditingComplete: widget.onEditingComplete,
          style: const TextStyle(
            fontSize: 16.0,
            height: 1.1,
          ),
        ),
      )
    );
  }
}
