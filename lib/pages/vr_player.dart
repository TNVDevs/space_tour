import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VRPlayerScreen extends StatefulWidget {
  final String? videoId;
  const VRPlayerScreen({super.key, this.videoId});

  @override
  State<VRPlayerScreen> createState() => _VRPlayerScreenState();
}

class _VRPlayerScreenState extends State<VRPlayerScreen> {
  late final YoutubePlayerController _ytController;
  final List<_ChatMessage> _messages = [];
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String videoTitle =
      "Live: Tour of the United States – From Coast to Coast 🇺🇸";
  String videoDescription =
      "A 12-minute 360° demo flyover of the United States — coast to coast. "
      "See major landmarks and urban lights from orbit. (Demo content)";
  String videoDuration = "12:00";

  @override
  void initState() {
    super.initState();

    final id = widget.videoId ?? 'Kgb5efL2dng';
    _ytController = YoutubePlayerController.fromVideoId(
      videoId: id,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableCaption: false,
        strictRelatedVideos: true,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _messages.add(
          _ChatMessage(
            text:
                "Hi! Ask me about the tour (landmarks, suggested viewing points, or classroom activities).",
            isUser: false,
          ),
        );
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _ytController.close();
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (!mounted) return;
    setState(
      () => _messages.add(_ChatMessage(text: text.trim(), isUser: true)),
    );
    _chatController.clear();
    _scrollToBottom();

    if (!mounted) return;
    setState(
      () => _messages.add(
        _ChatMessage(text: "AI is typing...", isUser: false, isThinking: true),
      ),
    );
    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    final reply = _generateMockAIReply(text.trim());

    setState(() {
      final index = _messages.indexWhere((m) => m.isThinking);
      if (index != -1) _messages.removeAt(index);
      _messages.add(_ChatMessage(text: reply, isUser: false));
    });

    _scrollToBottom();
  }

  String _generateMockAIReply(String userMessage) {
    final lc = userMessage.toLowerCase();

    if (lc.contains("landmark") ||
        lc.contains("what can i see") ||
        lc.contains("see")) {
      return "You’ll see many major landmarks on this pass — e.g. the Grand Canyon (Southwest), Golden Gate in the San Francisco area, the Rocky Mountains further inland, and the bright skyline of New York City on the East Coast. If you want details about a specific city, ask me the name!";
    }

    if (lc.contains("overview") || lc.contains("overview effect")) {
      return "The “overview effect” is a cognitive shift experienced by many astronauts when viewing Earth from space — a sense of interconnectedness and seeing national borders disappear. This VR tour is designed to help invoke that feeling with real-time 360° imagery.";
    }

    if (lc.contains("class") ||
        lc.contains("lesson") ||
        lc.contains("school")) {
      return "For classroom use: plan a 15–20 minute session — 5 mins intro, 10–12 mins live tour, 3–5 mins Q&A. Use the chat to ask students to note geographic patterns (rivers, mountain ranges, urbanization) and discuss human-environment interaction.";
    }

    if (lc.contains("how") && lc.contains("work")) {
      return "We partner with commercial satellite operators to stream 360° or wide-angle video. For the demo, the app plays recorded 360 HLS/MP4 content timed to 'passes'. In production, live streams or low-latency WebRTC can be used.";
    }

    if (lc.contains("tips") || lc.contains("best")) {
      return "Best viewing tips: use headphones, lock the headset view to stabilize motion, and try both daytime and nighttime passes — night passes show city lighting and are great for identifying major urban centers.";
    }

    // fallback reply that references the video
    return "Great question! This tour lasts $videoDuration and highlights continental flight over the U.S. (coast-to-coast). Ask me about a city, landmark, or how to run a classroom session using this tour.";
  }

  void _scrollToBottom() {
    Timer(const Duration(milliseconds: 50), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              videoTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Chip(
                  label: Text("Education"),
                  backgroundColor: Colors.blueGrey,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Chip(
                  label: Text("360°"),
                  backgroundColor: Colors.blueGrey,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      videoDuration,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              videoDescription,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _ytController.playVideo();
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Play"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Share link copied (demo)."),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text("Share"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(_ChatMessage msg) {
    final alignment = msg.isUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final bg = msg.isUser ? Colors.black : Colors.black;
    final textColor = Colors.white;
    final radius = msg.isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.78,
          ),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: bg, borderRadius: radius),
          child: msg.isThinking
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "AI is typing...",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                )
              : Text(msg.text, style: TextStyle(color: textColor)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "VR Player",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[800],
                builder: (_) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ActionChip(
                            label: const Text("What are the landmarks?"),
                            backgroundColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                              _sendMessage(
                                "What landmarks are visible on this tour?",
                              );
                            },
                          ),
                          ActionChip(
                            label: const Text("Create a class plan"),
                            backgroundColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                              _sendMessage(
                                "How to use this tour with my class?",
                              );
                            },
                          ),
                          ActionChip(
                            label: const Text("Explain the 'overview effect'"),
                            backgroundColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                              _sendMessage("Explain the overview effect.");
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.smart_toy_rounded, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(controller: _ytController),
          ),

          _buildInfoCard(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
            child: Row(
              children: const [
                Icon(Icons.chat_bubble_outline, color: Colors.white70),
                SizedBox(width: 8),
                Text(
                  "AI Tour Assistant",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),

          // Chat area
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (_, i) => _buildChatBubble(_messages[i]),
                    ),
                  ),

                  // Input field
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _chatController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: const InputDecoration(
                                        hintStyle: TextStyle(
                                          color: Colors.white54,
                                        ),
                                        hintText: "Ask the tour assistant...",
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (v) => _sendMessage(v),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      final v = _chatController.text;
                                      if (v.isNotEmpty) {
                                        _sendMessage(v);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _ChatMessage {
  final String text;
  final bool isUser;
  final bool isThinking;
  _ChatMessage({
    required this.text,
    this.isUser = false,
    this.isThinking = false,
  });
}
