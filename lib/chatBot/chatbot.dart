import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ChatMessage.dart';
import 'ike_chatbot_config.dart' as local;
import 'keywords_respons.dart';

class ChatBot extends StatefulWidget {
  final local.IkChatBotConfig config;

  const ChatBot({Key? key, required this.config}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  Timer? _inactivityTimer;
  Timer? _closeTimer;
  bool _isWaitingForUserResponse = true;
  bool _showTextField = true;

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      botColor: widget.config.botChatColor,
      botIcon: widget.config.botIcon,
      userColor: widget.config.userChatColor,
      userIcon: widget.config.userIcon,
      text: widget.config.initialGreeting,
      isUser: false,
      messageTime: DateTime.now(),
    ));

    _startInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _closeTimer?.cancel();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _inactivityTimer?.cancel();
    _closeTimer?.cancel();

    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        botColor: widget.config.botChatColor,
        botIcon: widget.config.botIcon,
        userColor: widget.config.userChatColor,
        userIcon: widget.config.userIcon,
        text: text,
        isUser: true,
        messageTime: DateTime.now(),
      ));
    });

    _textController.clear();
    _handleUserResponse(text);
  }

  int _findMatchingKeyword(String response) {
    for (int i = 0; i < widget.config.keywords.length; i++) {
      if (response.contains(widget.config.keywords[i])) {
        return i;
      }
    }
    return -1;
  }

  void _handleUserResponse(String response) {
    final lowerCaseResponse = response.trim().toLowerCase();

    String reply;
    String userSelectedOption;

    final int index = _findMatchingKeyword(lowerCaseResponse);

    if (index != -1) {
      userSelectedOption = response;
      reply = widget.config.responses[index];
    } else {
      userSelectedOption = "";
      reply = widget.config.defaultResponse;
    }

    // Periksa apakah pesan pengguna telah ditambahkan sebelumnya
    bool isUserMessageAdded =
        _messages.any((message) => message.text == userSelectedOption);

    if (!isUserMessageAdded && userSelectedOption.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          botColor: widget.config.botChatColor,
          botIcon: widget.config.botIcon,
          userColor: widget.config.userChatColor,
          userIcon: widget.config.userIcon,
          text: userSelectedOption,
          isUser: true,
          messageTime: DateTime.now(),
        ));
      });
    }

    setState(() {
      _isWaitingForUserResponse = false;
    });

    Future.delayed(Duration(seconds: widget.config.delayResponse), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            botColor: widget.config.botChatColor,
            botIcon: widget.config.botIcon,
            userColor: widget.config.userChatColor,
            userIcon: widget.config.userIcon,
            text: reply,
            isUser: false,
            messageTime: DateTime.now(),
          ));
          _startInactivityTimer();
        });
        _textController.clear();
      }
    });
  }

  void _startInactivityTimer() {
    _inactivityTimer = Timer(Duration(minutes: widget.config.waitingTime), () {
      if (mounted) {
        if (!_isWaitingForUserResponse) {
          setState(() {
            _messages.add(ChatMessage(
              botColor: widget.config.botChatColor,
              botIcon: widget.config.botIcon,
              userColor: widget.config.userChatColor,
              userIcon: widget.config.userIcon,
              text: widget.config.inactivityMessage,
              isUser: false,
              messageTime: DateTime.now(),
            ));
            _isWaitingForUserResponse = true;
            _startInactivityTimer();
          });
        } else {
          _startCloseTimer();
        }
      }
    });
  }

  void _startCloseTimer() {
    _closeTimer = Timer(const Duration(minutes: 5), () {
      if (mounted) {
        setState(() {
          _showTextField = false;
          _messages.add(ChatMessage(
            botColor: widget.config.botChatColor,
            botIcon: widget.config.botIcon,
            userColor: widget.config.userChatColor,
            userIcon: widget.config.userIcon,
            text: widget.config.closingMessage,
            isUser: false,
            messageTime: DateTime.now(),
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 39, 63),
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text('Bot Mentioners', style: TextStyle(fontSize: 17.5)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg_mentioners.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: widget.config.backgroundImageAsset != null
                    ? DecorationImage(
                        image: AssetImage(widget.config.backgroundImageAsset!),
                        fit: BoxFit.cover,
                      )
                    : widget.config.backgroundImageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(widget.config.backgroundImageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        reverse: true,
                        itemBuilder: (_, int index) =>
                            _messages.reversed.toList()[index],
                        itemCount: _messages.length,
                      ),
                    ),
                  ),
                  _buildTextComposer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    if (!_showTextField) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.config.backgroundColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  if (!_isWaitingForUserResponse) {
                    _isWaitingForUserResponse = true;
                  }
                },
                decoration: InputDecoration.collapsed(
                  hintText: widget.config.inputHint,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _handleSubmitted(_textController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
