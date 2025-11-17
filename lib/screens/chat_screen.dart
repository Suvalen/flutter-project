import 'package:flutter/material.dart';

// Main chat interface screen
// Shows AI capability cards and message input field
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _capabilities = [
    'Remembers what user said earlier in the conversation',
    'Allows user to provide follow-up Questions and correctoions',
    'Trained to decline inappropriate requests',
    'May occasionally generate incorrect information',
    'Limited knowledge of world and events after 2023',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // TODO: Implement message sending logic
      print('Sending message: ${_messageController.text}');
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with logo
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/FullLogo_Transparent.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Medi-Bot',
                style: TextStyle(
                  color: Color(0xFF131416),
                  fontSize: 24,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        // Capability cards in scrollable area
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'Capabilities',
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ..._capabilities.map((capability) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildCapabilityCard(capability),
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // Message input field at bottom
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F8FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(
                      color: Color(0xFF323142),
                      fontSize: 15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Send a message.',
                      hintStyle: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF155DFC),
                    shape: CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCapabilityCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF155DFC),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF323142),
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
