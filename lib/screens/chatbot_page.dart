import 'package:flutter/material.dart';
import 'home_page.dart';
import '../models/user_data.dart';

import 'package:frontend/widgets/top_nav_bar.dart';

class ChatbotPage extends StatefulWidget {
  final UserData userData;

  const ChatbotPage({super.key, required this.userData});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'sender': 'bot', 'text': '안녕하세요 Fit4you 입니다! 무엇을 도와드릴까요?'},
  ];

  void _handleSendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _controller.clear();
    });

    setState(() {
      _messages.add({'sender': 'bot', 'text': '대화 생성 중...'});
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _messages.removeLast();
      _messages.add({
        'sender': 'bot',
        'text': '''
주 3회 유산소 위주 루틴을 추천드릴게요!
아래 운동들을 1일 1세트로 구성해보세요 😊

• Bear Crawl (3세트 x 20초)
• Mountain Climber (3세트 x 30회)
• Jumping Jack (4세트 x 15회)
''',
        'action': 'addRoutine',
      });
    });
  }

  void _addRoutineToHome() {
    final newRoutine = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "title": "주 3회 유산소 루틴",
      "tags": ["유산소", "중급", "홈트"],
      "isPinned": false,
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          userData: widget.userData,
          newRoutine: newRoutine,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
            left: 40,
            top: 20,
            child: SizedBox(width: 60, height: 24),
          ),
          Positioned(
            top: 44,
            left: 0,
            right: 0,
            child: TopNavBar(
              assetPrefix: 'assets/chatbot',
              redirectRoute: '/home',
              userData: widget.userData,
            ),
          ),
          Positioned(
            top: 124,
            left: 0,
            right: 0,
            bottom: 60,
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['sender'] == 'user';
                  final isBotWithAction = message['sender'] == 'bot' &&
                      message['action'] == 'addRoutine';

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isUser
                            ? const Color(0xFF1A237E)
                            : const Color(0x191A237E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: isUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                            ),
                          ),
                          if (message['action'] == 'addRoutine')
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: _addRoutineToHome,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 116, 122, 188), // Fit4you 파랑
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        '추가',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Pretendard',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _handleSendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF1A237E)),
                    onPressed: _handleSendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
