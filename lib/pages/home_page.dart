import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/mermaid_diagram.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _chatHistory = [
    {'id': const Uuid().v4(), 'title': 'Network Config 1', 'messages': []},
    {'id': const Uuid().v4(), 'title': 'Diagram Setup', 'messages': []},
  ];
  String _selectedChatId = '';

  @override
  void initState() {
    super.initState();
    if (_chatHistory.isNotEmpty) {
      _selectedChatId = _chatHistory.first['id'];
    }
  }

  void _renameChat(String id, String newTitle) {
    setState(() {
      final index = _chatHistory.indexWhere((chat) => chat['id'] == id);
      _chatHistory[index]['title'] = newTitle;
    });
  }

  void _deleteChat(String id) {
    setState(() {
      _chatHistory.removeWhere((chat) => chat['id'] == id);
      if (_selectedChatId == id && _chatHistory.isNotEmpty) {
        _selectedChatId = _chatHistory.first['id'];
      } else if (_chatHistory.isEmpty) {
        _selectedChatId = '';
      }
    });
  }

  void _addNewChat() {
    setState(() {
      final newChat = {
        'id': const Uuid().v4(),
        'title': 'New Chat',
        'messages': [],
      };
      _chatHistory.add(newChat);
      _selectedChatId = newChat['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NetBot'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // History Sidebar
            SizedBox(
              width: 250,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Chat History'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _addNewChat,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _chatHistory.length,
                      itemBuilder: (context, index) {
                        final chat = _chatHistory[index];
                        return ListTile(
                          title: Text(chat['title']),
                          selected: chat['id'] == _selectedChatId,
                          onTap: () {
                            setState(() {
                              _selectedChatId = chat['id'];
                            });
                          },
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'rename',
                                child: const Text('Rename'),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final controller = TextEditingController(
                                          text: chat['title']);
                                      return AlertDialog(
                                        title: const Text('Rename Chat'),
                                        content: TextField(controller: controller),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              _renameChat(
                                                  chat['id'], controller.text);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Save'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: const Text('Delete'),
                                onTap: () {
                                  _deleteChat(chat['id']);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Chat Area
            Expanded(
              child: _selectedChatId.isEmpty
                  ? const Center(child: Text('No chats available'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(16),
                            children: [
                              // Dummy Chat Data
                              const ChatBubble(
                                isUser: false,
                                message: 'Hello! How can I assist with your network?',
                              ),
                              const ChatBubble(
                                isUser: true,
                                message: 'Show me a network diagram.',
                              ),
                              const MermaidDiagram(
                                code: '''
graph TD
  A[Router] --> B[Switch]
  B --> C[Server]
  B --> D[Client]
''',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Type your message...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}