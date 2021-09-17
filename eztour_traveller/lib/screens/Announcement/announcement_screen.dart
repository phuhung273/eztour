
import 'package:eztour_traveller/screens/Announcement/announcement_screen_controller.dart';
import 'package:eztour_traveller/screens/Main/main_screen_controller.dart';
import 'package:eztour_traveller/widgets/inline_text_field.dart';
import 'package:eztour_traveller/widgets/swipeable_inline_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementScreen extends StatelessWidget {

  final AnnouncementScreenController _controller = Get.put(AnnouncementScreenController());

  @override
  Widget build(BuildContext context) {

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: context.height * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/notebook.png'),
                  fit: BoxFit.cover,
                )
            ),
            child: Column(
              children: [
                Container(
                  child: const Text(
                    'Tour Guide',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                _buildTourGuideAnnouncement(),
              ],
            ),
          ),
          Container(
            height: context.height * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/notebook.png'),
                  fit: BoxFit.cover,
                )
            ),
            child: Column(
              children: [
                Container(
                  child: const Text(
                    'Tourist',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                _buildTouristAnnouncement(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTouristAnnouncement() {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: _controller.myAnnouncements.length + 1,
            itemBuilder: (BuildContext context, int index) {

              if(index == _controller.myAnnouncements.length){
                return Container(
                  margin: const EdgeInsets.only(left: 36.0, top: 4.0),
                  child: InlineTextField(
                    text: '',
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        height: 1.1,
                      ),
                    ),
                    onEditingComplete: _controller.add,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.1,
                    ),
                  ),
                );
              }

              return _buildSwipeCell(index);
            },
          ),
        ),
      ),
    );

  }

  Widget _buildSwipeCell(int index) {
    final announcement = _controller.myAnnouncements[index];

    return SwipeableInlineEditText(
      key: ValueKey(announcement),
      text: announcement.message,
      onEditingComplete: (value) => _controller.updateAt(index, value),
      onDelete: () => _controller.removeAt(index),
    );
  }

  Widget _buildTourGuideAnnouncement() {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: _controller.announcements.length,
            itemBuilder: (BuildContext context, int index) {

              final announcement = _controller.announcements[index];

              return Container(
                margin: const EdgeInsets.only(left: 36.0, top: 4.0),
                child:  Text(
                    '• ${announcement.message}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.1,
                    )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

const contentWidthRatio = 0.8;
const bottomBarHeight = 80.0; // According to: https://github.com/flutter/flutter/issues/26173

class Background extends StatelessWidget {
  final Widget child;
  Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  final MainScreenController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {

    final screenHeight = context.height - bottomBarHeight;
    final pencilWidth = context.width * (1 - contentWidthRatio);
    final contentWidth = context.width * contentWidthRatio;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: (){},
        ),
        // title: Text(_controller.greeting.value),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _mainController.logOut,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.pink[100],
          ),
          child: Stack(
            children: [
              Positioned(
                top: context.height * 0.3,
                child: Image.asset(
                  'assets/images/pencil.png',
                  width: pencilWidth,
                )
              ),
              Positioned(
                left: pencilWidth,
                height: screenHeight,
                width: contentWidth,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

