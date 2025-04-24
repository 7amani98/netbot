import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/mermaid_diagram.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
  bool _isSidebarExpanded = true; // Sidebar expanded by default

  @override
  void initState() {
    super.initState();
    if (_chatHistory.isNotEmpty) {
      _selectedChatId = _chatHistory.first['id'] as String;
      _isSidebarExpanded = true; // Ensure sidebar is expanded initially
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
        _selectedChatId = _chatHistory.first['id'] as String;
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
        'messages': <String>[],
      };
      _chatHistory.add(newChat);
      _selectedChatId = newChat['id'] as String;
      _isSidebarExpanded = false; // Collapse sidebar when adding new chat
    });
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sidebarWidth = _isSidebarExpanded ? 400.0 : 60.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NetBot'),
        backgroundColor: const Color(0xFF16213E),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white70),
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
            // Sidebar
            ClipRect(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: sidebarWidth,
                color: const Color(0xFF0F0F1B),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      maxWidth: 400.0,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          title: _isSidebarExpanded
                              ? const Text(
                                  'Chat History',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                          trailing: IconButton(
                            icon: Icon(
                              _isSidebarExpanded
                                  ? Icons.arrow_left
                                  : Icons.arrow_right,
                              color: Colors.white70,
                            ),
                            onPressed: _toggleSidebar,
                          ),
                        ),
                        if (_isSidebarExpanded)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _chatHistory.length,
                            itemBuilder: (context, index) {
                              final chat = _chatHistory[index];
                              return ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                leading: Icon(
                                  Icons.chat_bubble_outline,
                                  color: chat['id'] == _selectedChatId
                                      ? const Color(0xFF6B4CAF)
                                      : Colors.white70,
                                  size: 20,
                                ),
                                title: Text(
                                  chat['title'] as String,
                                  style: TextStyle(
                                    color: chat['id'] == _selectedChatId
                                        ? const Color(0xFF6B4CAF)
                                        : Colors.white,
                                    fontWeight: chat['id'] == _selectedChatId
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedChatId = chat['id'] as String;
                                    _isSidebarExpanded = false;
                                  });
                                },
                                trailing: PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert,
                                      color: Colors.white70, size: 20),
                                  onSelected: (value) {
                                    if (value == 'rename') {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          final controller =
                                              TextEditingController(
                                                  text: chat['title'] as String);
                                          return AlertDialog(
                                            backgroundColor:
                                                const Color(0xFF16213E),
                                            title: const Text(
                                              'Rename Chat',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            content: TextField(
                                              controller: controller,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Chat Title',
                                                labelStyle: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  _renameChat(
                                                      chat['id'] as String,
                                                      controller.text);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Save',
                                                  style: TextStyle(
                                                      color: Color(0xFF6B4CAF)),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else if (value == 'delete') {
                                      _deleteChat(chat['id'] as String);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'rename',
                                      child: Text(
                                        'Rename',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        if (_isSidebarExpanded)
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            leading:
                                const Icon(Icons.add, color: Colors.white70),
                            title: const Text(
                              'New Chat',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: _addNewChat,
                          ),
                      ],
                    ),
                  ),
                ),
              ).animate().slideX(),
            ),
            // Chat Area
            Expanded(
              child: Container(
                color: const Color(0xFF1A1A2E),
                child: Column(
                  children: [
                    // Chat Area Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: const Color(0xFF16213E),
                      child: Row(
                        children: [
                          if (!_isSidebarExpanded)
                            IconButton(
                              icon: const Icon(Icons.menu,
                                  color: Colors.white70, size: 24),
                              onPressed: _toggleSidebar,
                              tooltip: 'Expand Sidebar',
                            ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _selectedChatId.isEmpty
                          ? const Center(
                              child: Text(
                                'No chats available',
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          : ListView(
                              padding: const EdgeInsets.all(16),
                              children: const [
                                ChatBubble(
                                  isUser: false,
                                  message:
                                      'Hello! How can I assist with your network?',
                                ),
                                ChatBubble(
                                  isUser: true,
                                  message: 'Show me a network diagram.',
                                ),
                                MermaidDiagram(
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
                                hintStyle: const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: const Color(0xFF0F0F1B),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send,
                                color: Color(0xFF6B4CAF)),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}