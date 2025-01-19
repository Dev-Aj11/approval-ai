class MessageData {
  final String content;
  final DateTime timestamp;
  final bool isFromAgent;
  final String mode;

  MessageData(
      {required this.content,
      required this.timestamp,
      required this.isFromAgent,
      required this.mode});
}

// final kSampleInteractionDataList = [
//   InteractionData(
//     lender: "US Bank",
//     loanOfficer: "John Doe",
//     status: [LenderStatusEnum.contacted],
//     lastContacted: DateTime(2025, 1, 1),
//     messages: [
//       MessageData(
//           content:
//               "Hi Karen, I'm Arjun Lalwani, interested in applying for a mortgage loan for a property in NYC. I came across your profile on the US Bank Site. I was wondering if it's necessary to create an account on US Bank to get a loan estimate document? Can I provide my documents to you over email or over the phone to get a loan estimate document from US Bank? Thanks! Best, Arjun",
//           timestamp: DateTime(2025, 1, 1),
//           isFromAgent: true,
//           mode: "email"),
//       MessageData(
//         content:
//             "Hi Arjun, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
//         timestamp: DateTime(2025, 1, 1),
//         isFromAgent: false,
//         mode: "email",
//       ),
//       MessageData(
//         content:
//             "Hi Karen, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
//         timestamp: DateTime(2025, 1, 1),
//         isFromAgent: true,
//         mode: "email",
//       ),
//       MessageData(
//         content:
//             "Hi Karen, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
//         timestamp: DateTime(2025, 1, 1),
//         isFromAgent: false,
//         mode: "email",
//       ),
//       MessageData(
//         content:
//             "Hi Karen, Thank you for reaching out. You can provide your documents over email or over the phone to get a loan estimate document from US Bank. You can also create an account on US Bank to get a loan estimate document. Best, Karen",
//         timestamp: DateTime(2025, 1, 1),
//         isFromAgent: true,
//         mode: "email",
//       ),
//     ],
//     preview: "This is a preview of the interaction",
//     estimateUrl: "https://www.google.com",
//   ),
//   InteractionData(
//     lender: "Chase Bank",
//     loanOfficer: "Jane Doe",
//     status: [LenderStatusEnum.negotiating],
//     lastContacted: DateTime(2025, 1, 1),
//     messages: [
//       MessageData(
//           content: "This is a preview of the interaction",
//           timestamp: DateTime(2025, 1, 1),
//           isFromAgent: true,
//           mode: "email"),
//       MessageData(
//           content: "This is an estimate of the interaction",
//           timestamp: DateTime(2025, 1, 1),
//           isFromAgent: false,
//           mode: "email")
//     ],
//     preview: "This is a preview of the interaction",
//     estimateUrl: "https://www.google.com",
//   ),
//   InteractionData(
//     lender: "Citi Bank",
//     loanOfficer: "John Doe",
//     status: [LenderStatusEnum.complete],
//     lastContacted: DateTime(2025, 1, 1),
//     messages: [
//       MessageData(
//           content: "This is a preview of the interaction",
//           timestamp: DateTime(2025, 1, 1),
//           isFromAgent: true,
//           mode: "email"),
//       MessageData(
//           content: "This is an estimate of the interaction",
//           timestamp: DateTime(2025, 1, 1),
//           isFromAgent: false,
//           mode: "email")
//     ],
//     preview: "This is a preview of the interaction",
//     estimateUrl: "https://www.google.com",
//   ),
// ];
