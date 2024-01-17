import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF128C7E),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [
    Message(sender: "ABC",text: 'Hi there!', date: DateTime(2023, 12, 20), isSentByMe: false),
    Message(sender: "ABC",text: 'Hello! How are you?', date: DateTime(2023, 12, 20), isSentByMe: true),
    // ... more messages for December 20th
    Message(sender: "ABC",text: 'Good morning!', date: DateTime.now(), isSentByMe: false),
    Message(sender: "ABC",text: 'Good morning! Did you get the files?', date: DateTime.now(), isSentByMe: true),
    // ... more messages for today
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black, // Change the background color to black
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Change icon color to white if needed
          onPressed: () {
            // TODO: implement this
          },
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // TODO: implement this
                },
              ),
              Positioned( // Adjust the position as needed
                top: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light, // Ensure the status bar icons are light
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  final msg = _messages[_messages.length - index - 1];
                  return _buildMessage(
                    msg.text,
                    msg.isSentByMe,
                    msg.date,
                    msg.sender, // Pass the sender's name here
                  );
                },
              ),
            ),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String text, bool isSentByMe, DateTime date, String sender) {
    final alignment = isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isSentByMe ? Colors.green[300] : Colors.grey[300];
    final borderRadius = BorderRadius.circular(20);
    final margin = isSentByMe
        ? EdgeInsets.only(
      top: 4.0,
      bottom: 4.0,
      left: 40.0,
    )
        : EdgeInsets.only(
      top: 4.0,
      bottom: 4.0,
      right: 40.0,
    );

    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Container(
          margin: margin,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isSentByMe ? "You": sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSentByMe ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                  color: isSentByMe ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 2.0,
            left: isSentByMe ? 0 : 10,
            right: isSentByMe ? 10 : 0,
          ),
          child: Text(
            DateFormat('MMM d, hh:mm a').format(date),
            style: TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildTextComposer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              color: Color(0xFF087949).withOpacity(0.08),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Implement attachment functionality
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.attach_file, color: Colors.white),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration(
                      hintText: "Leave a message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _handleSubmitted(String text) {
    _textController.clear();
    final message = Message(sender: "You",text: text, date: DateTime.now(), isSentByMe: true);
    setState(() {
      _messages.add(message);
    });
    // TODO: implement this
    /// In a real app, you would also want to send the message to the backend.
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class Message {
  String text;
  DateTime date;
  bool isSentByMe;
  String sender;

  Message({
    required this.text,
    required this.date,
    required this.isSentByMe,
    required this.sender,
  });
}