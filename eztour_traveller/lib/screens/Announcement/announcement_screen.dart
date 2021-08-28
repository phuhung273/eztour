
import 'package:eztour_traveller/datasource/remote/announcement_service.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/announcement/announcement_list_request.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {

  final service = AnnouncementService(Dio(BaseOptions(contentType: "application/json")));

  List<Announcement> _announcements = [];

  // List<Announcement> _announcements = [
  //   Announcement(id: 1, message: "Design"),
  //   Announcement(id: 2, message: "Code"),
  //   Announcement(id: 3, message: "Review"),
  // ];

  @override
  void initState() {
    _getTodoList();

    super.initState();
  }

  Future _getTodoList() async {
    try {
      final response = await service.getAnnouncementList(AnnouncementListRequest());

      setState(() {
        _announcements = response.announcements;
      });
    } catch(e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "Announcement",
            style: TextStyle(fontSize: 25.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: _announcements.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child:  ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  title: Text(_announcements[index].message, style: const TextStyle(fontSize: 20)),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          )
        ],
      ),
    );
  }
}
