import 'package:approval_ai/screens/home/model/overview_data.dart';

class Message {
  final String content;
  final DateTime timestamp;
  final bool isFromAgent;
  final String deliveryType;

  Message(this.content, this.timestamp, this.isFromAgent, this.deliveryType);
}

class InteractionData {
  final String lender;
  final List<LenderStatusEnum> status;
  final DateTime lastContacted;
  final List<Message> messages;
  final String preview;
  final String? estimateUrl;

  InteractionData(this.lender, this.status, this.lastContacted, this.messages,
      this.preview, this.estimateUrl);
}

final kSampleInteractionDataList = [
  InteractionData(
    "US Bank",
    [LenderStatusEnum.contacted],
    DateTime(2025, 1, 1),
    [
      Message("This is a preview of the interaction", DateTime(2025, 1, 1),
          true, "email"),
      Message("This is an estimate of the interaction", DateTime(2025, 1, 1),
          false, "email")
    ],
    "This is a preview of the interaction",
    "https://www.google.com",
  ),
  InteractionData(
    "Chase Bank",
    [LenderStatusEnum.contacted],
    DateTime(2025, 1, 1),
    [
      Message("This is a preview of the interaction", DateTime(2025, 1, 1),
          true, "email"),
      Message("This is an estimate of the interaction", DateTime(2025, 1, 1),
          false, "email")
    ],
    "This is a preview of the interaction",
    "https://www.google.com",
  ),
  InteractionData(
    "Citi Bank",
    [LenderStatusEnum.contacted],
    DateTime(2025, 1, 1),
    [
      Message("This is a preview of the interaction", DateTime(2025, 1, 1),
          true, "email"),
      Message("This is an estimate of the interaction", DateTime(2025, 1, 1),
          false, "email")
    ],
    "This is a preview of the interaction",
    "https://www.google.com",
  ),
];
