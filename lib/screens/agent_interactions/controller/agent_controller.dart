import 'package:approval_ai/screens/agent_interactions/model/interaction_data.dart';

class AgentController {
  static sortMessages(List<MessageData> messages) {
    // sort messages by timestamp
    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return messages;
  }
}
