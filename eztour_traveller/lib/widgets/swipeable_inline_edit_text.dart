import 'package:eztour_traveller/widgets/inline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class SwipeableInlineEditText extends StatefulWidget {
  final String text;
  final void Function(String value) onEditingComplete;

  const SwipeableInlineEditText({
    required this.text,
    required this.onEditingComplete,
    required Key key,
  }) : super(key: key);

  @override
  _SwipeableInlineEditTextState createState() => _SwipeableInlineEditTextState();
}

class _SwipeableInlineEditTextState extends State<SwipeableInlineEditText> {

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
          nestedAction: SwipeNestedAction(
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red,
              ),
              child: OverflowBox(
                maxWidth: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    Text('Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///you should set the default  bg color to transparent
          color: Colors.transparent,

          ///set content instead of title of icon
          content: _buildIconButton(Colors.red, Icons.delete),
          onTap: (handler) async {
            await handler(true);
            // _controller.removeAt(index);
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

  Widget _buildIconButton(Color color, IconData icon) {
    return Container(
      width: 50.0,
      height: 25.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20.0,
      ),
    );
  }
}
