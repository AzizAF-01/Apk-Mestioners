import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final DateTime messageTime;
  final Color botColor;
  final Color userColor;
  final Icon botIcon;
  final Icon userIcon;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.messageTime,
    required this.botIcon,
    required this.userIcon,
    required this.botColor,
    required this.userColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUser)
                Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: !isUser
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            radius: 18.0,
                            child: botIcon,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 18.0,
                            child: userIcon,
                          )),
              Container(
                constraints: BoxConstraints(),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: isUser ? userColor : botColor,
                  borderRadius: isUser
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.65,
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: isUser ? Colors.black : Colors.white,
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${messageTime.hour}:${messageTime.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUser)
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CircleAvatar(
                    backgroundColor: userColor,
                    radius: 20.0,
                    child: userIcon,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
