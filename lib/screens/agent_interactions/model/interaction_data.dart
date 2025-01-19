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
  final String loanOfficer;
  final List<LenderStatusEnum> status;
  final DateTime lastContacted;
  final List<Message> messages;
  final String preview;
  final String? estimateUrl;

  InteractionData(this.lender, this.loanOfficer, this.status,
      this.lastContacted, this.messages, this.preview, this.estimateUrl);
}

final kSampleInteractionDataList = [
  InteractionData(
    "US Bank",
    "John Doe",
    [LenderStatusEnum.contacted],
    DateTime(2025, 1, 1),
    [
      Message(
          "Hi Karen, I'm Arjun Lalwani, interested in applying for a mortgage loan for a property in NYC. I came across your profile on the US Bank Site. I was wondering if it's necessary to create an account on US Bank to get a loan estimate document? Can I provide my documents to you over email or over the phone to get a loan estimate document from US Bank? Thanks! Best, Arjun",
          DateTime(2025, 1, 1),
          true,
          "email"),
      Message(
        "Hi Arjun, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
        DateTime(2025, 1, 1),
        false,
        "email",
      ),
      Message(
        "Hi Karen, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
        DateTime(2025, 1, 1),
        true,
        "email",
      ),
      Message(
        "Hi Karen, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
        DateTime(2025, 1, 1),
        false,
        "email",
      ),
      Message(
        "Hi Karen, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
        DateTime(2025, 1, 1),
        true,
        "email",
      ),
    ],
    "This is a preview of the interaction",
    "https://www.google.com",
  ),
  InteractionData(
    "Chase Bank",
    "Jane Doe",
    [LenderStatusEnum.negotiating],
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
    "John Doe",
    [LenderStatusEnum.complete],
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
