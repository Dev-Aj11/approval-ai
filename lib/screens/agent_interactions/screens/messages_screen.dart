import 'dart:math';
import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatelessWidget {
  final InteractionData interactionData;
  const MessagesScreen({super.key, required this.interactionData});

  @override
  Widget build(BuildContext context) {
    final messages = interactionData.messages;
    return Dialog(
      shadowColor: Colors.grey[400],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: _buildDialogContent(context, messages),
    );
  }

  Widget _buildDialogContent(BuildContext context, List<Message> messages) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 700,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildHeader(context),
          _buildMessages(context, messages, interactionData.loanOfficer),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 16, top: 16, bottom: 8),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${interactionData.loanOfficer} at ${interactionData.lender}",
            style: GoogleFonts.playfairDisplay(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
            iconSize: 18,
            style: IconButton.styleFrom(
              overlayColor: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessages(
      BuildContext context, List<Message> messages, String loanOfficer) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: messages.map<Widget>((message) {
              return _buildMessageBubble(context, message, loanOfficer);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
      BuildContext context, Message message, String loanOfficer) {
    final isAIAgent = message.isFromAgent;
    return Column(
      crossAxisAlignment:
          isAIAgent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        _buildSenderLabel(isAIAgent, loanOfficer),
        const SizedBox(height: 4),
        _buildMessageContent(context, message, isAIAgent),
        _buildMessageMetadata(isAIAgent),
      ],
    );
  }

  Widget _buildSenderLabel(bool isAIAgent, String loanOfficer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        isAIAgent ? 'AI Agent' : loanOfficer,
        style: const TextStyle(fontSize: 12, color: Color(0xff808080)),
      ),
    );
  }

  Widget _buildMessageContent(
      BuildContext context, Message message, bool isAIAgent) {
    return Container(
      width: max(MediaQuery.of(context).size.width * 0.35, 300),
      decoration: BoxDecoration(
        color: isAIAgent ? const Color(0xffE5F0FF) : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        message.content,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Widget _buildMessageMetadata(bool isAIAgent) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 32,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment:
            isAIAgent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(width: 8),
          Text(
            'Jan 14',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(width: 8),
          Text(
            '3:08 PM',
            style: const TextStyle(fontSize: 12, color: Color(0xff808080)),
          ),
        ],
      ),
    );
  }
}

/*
  Widget _buildMessages(context, messages) {
    return Container(
      width: max(MediaQuery.of(context).size.width * 0.3, 300),
      padding: const EdgeInsets.only(left: 24, right: 16, top: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("AI Agent"),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffE5F0FF),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            padding:
                const EdgeInsets.only(left: 24, right: 16, top: 24, bottom: 24),
            child: Text(messages.first.content),
          ),
          Row(
            children: [
              Text("Email"),
              Text("Jan 14"),
              Text("3:08 PM"),
            ],
          )
        ],
      ),
    );
  }*/



/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class CustomDialog extends StatelessWidget {
  final String header;
  final String imgPath;
  final String content;
  final String btnText;
  final Function onPressNext;
  const CustomDialog({
    super.key,
    required this.header,
    required this.content,
    required this.onPressNext,
    required this.imgPath,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        // ensure there is a minimum padding of 48px on smaller screens
        horizontal: max(MediaQuery.of(context).size.width * 0.04, 48.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("What Happens Next?",
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 14),
          Image(
            image: AssetImage(imgPath),
            // ensure the image is at least 300px wide and 300px high
            width: 300,
            height: 300,
          ),
          SizedBox(height: 14),
          Text(
            header,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xff0065FE),
            ),
          ),
          SizedBox(height: 20),
          Text(
            content,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 32),
          Container(
            alignment: Alignment.topRight,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff0065FE),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                foregroundColor: Colors.white,
              ),
              onPressed: () => onPressNext(),
              child: Text(btnText),
            ),
          ),
        ],
      ),
    );
  }
}
*/