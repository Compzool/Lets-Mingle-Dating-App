import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mingle/models/chat.dart';
import 'package:mingle/models/message.dart';
import 'package:mingle/models/user.dart';
import 'package:mingle/repositories/messagesRepository.dart';
import 'package:mingle/ui/pages/messaging.dart';
import 'package:mingle/ui/widgets/pageTurn.dart';

class ChatWidget extends StatefulWidget {
  final String userId, selectedUserId;
  final Timestamp creationTime;

  const ChatWidget({this.userId, this.selectedUserId, this.creationTime});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  MessageRepository messageRepository = MessageRepository();
  Chat chat;
  User user;

  getUserDetail() async{
    user = await messageRepository.getUserDetails(userId: widget.selectedUserId);
    Message message = await messageRepository.getLastMessage(currentUserId: widget.userId, selectedUserId: widget.selectedUserId).catchError((error){
      print(error);
    });

    if(message == null){
      return Chat(
        name: user.name,
        photoUrl: user.photo,
        lastMessage: null,
        lastMessagePhoto: null,
        timestamp: null,
      );
    } else{
      return Chat(
        name: user.name,
        photoUrl: user.photo,
        lastMessage: message.text,
        lastMessagePhoto: message.photoUrl,
        timestamp: message.timestamp,
      );
    }
  }

  openChat() async{
    User currentUser = await messageRepository.getUserDetails(userId: widget.userId);
    User selectedUser = await messageRepository.getUserDetails(userId: widget.selectedUserId);

    try{
      pageTurn(Messaging(currentUser: currentUser,
      selectedUser: selectedUser,), context);
    }catch(e){
      e.toString();
    }
  }

   deleteChat() async{
     await messageRepository.deleteChat(currentUserId: widget.userId, selectedUserId: widget.selectedUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
