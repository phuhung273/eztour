
import 'dart:convert';
import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/widgets/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'message_screen_controller.dart';


class MessageScreen extends StatelessWidget {

  final MessageScreenController _controller = Get.find();

  final LocalStorage _localStorage = Get.find();

  final _picker = ImagePicker();

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(_controller.name.value)),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _controller.sendLocationMessage,
          )
        ],
      ),
      body: Obx(
        () => DashChat(
          key: _chatViewKey,
          messages: _controller.messages.isEmpty ? [] : _controller.messages,
          user: ChatUser(
            name: _localStorage.getUsername(),
            uid: _localStorage.getUserID(),
          ),
          inputDecoration: const InputDecoration.collapsed(hintText: "Add message here..."),
          messageTimeBuilder: _buildTime,
          dateBuilder: _buildDate,
          messageDecorationBuilder: _buildMessageDecoration,
          messageImageBuilder: _buildImage,
          inputTextStyle: const TextStyle(fontSize: 16.0),
          inputContainerStyle: BoxDecoration(
            border: Border.all(width: 0.0),
            color: Colors.white,
          ),
          trailing: <Widget>[
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: _onPickImage,
            ),
          ],
          onSend: _controller.sendStringMessage,
        ),
      ),
    );
  }

  Future _onPickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      final bytes = File(image.path).readAsBytesSync();
      final base64Image =  "data:image/png;base64,${base64Encode(bytes)}";
      _controller.sendImageMessage(base64Image);
    }
  }

  Widget _buildTime(String time, [ChatMessage? message]) => const SizedBox();
  Widget _buildDate(String date) => Container();

  BoxDecoration _buildMessageDecoration(ChatMessage msg, bool? isUser){
    if(isUser == null) return const BoxDecoration();
    if(msg.image != null) return const BoxDecoration();

    return BoxDecoration(
      color: isUser
          ? primaryColorDark
          : const Color.fromRGBO(225, 225, 225, 1)
    );
  }

  Widget _buildImage(String? image, [ChatMessage? message]){
    if(message == null) return const SizedBox();
    if(message.isMapMessage()) return MapContainer(message: message.text);
    return ImageContainer(image: image);
  }
}

class ImageContainer extends StatelessWidget {
  final String? image;

  const ImageContainer({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraints = BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);

    return FadeInImage.memoryNetwork(
      height: constraints.maxHeight * 0.3,
      width: constraints.maxWidth * 0.7,
      fit: BoxFit.contain,
      placeholder: kTransparentImage,
      image: image!,
    );
  }
}

class MapContainer extends StatelessWidget {
  final String? message;

  const MapContainer({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraints = BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width);

    final latLong = message?.split(',');
    if(latLong == null) return const SizedBox();
    final coordinate = LatLng(double.parse(latLong[0]), double.parse(latLong[1]));

    return SizedBox(
      height: constraints.maxHeight * 0.3,
      width: constraints.maxWidth * 0.7,
      child: FlutterMap(
        options: MapOptions(
          center: coordinate,
          zoom: 17.0,
          maxZoom: 20.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: coordinate,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 36.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension MessageType on ChatMessage{
  bool isMapMessage(){
    if(image == null || text == null) return false;
    return image!.isEmpty && text!.isNotEmpty;
  }
}