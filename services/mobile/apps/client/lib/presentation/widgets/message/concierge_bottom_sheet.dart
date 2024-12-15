import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';

class ConciergeBottomSheet extends ConsumerStatefulWidget {
  final String userId;

  const ConciergeBottomSheet({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<ConciergeBottomSheet> createState() =>
      _ConciergeBottomSheetState();
}

class _ConciergeBottomSheetState extends ConsumerState<ConciergeBottomSheet> {
  final _questionController = TextEditingController();
  String? _response;
  bool _isLoading = false;

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _askQuestion() async {
    if (_questionController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ref.read(graphQLClientProvider).query(
            QueryOptions(
              document: gql('''
            query AskLlm(\$userId: String!, \$question: String!) {
              askLlm(userId: \$userId, question: \$question)
            }
          '''),
              variables: {
                'userId': widget.userId,
                'question': _questionController.text,
              },
              fetchPolicy: FetchPolicy.noCache,
              cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
              errorPolicy: ErrorPolicy.all,
              pollInterval: const Duration(seconds: 30),
            ),
          );

      if (result.hasException) {
        throw result.exception!;
      }

      setState(() {
        _response = result.data?['askLlm'] as String?;
        _isLoading = false;
      });

      _questionController.clear();
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
        _isLoading = false;
      });

      print('Error in _askQuestion: $e');
    }
  }

  Widget _buildFormattedText(String text) {
    final List<InlineSpan> spans = [];
    final RegExp pattern = RegExp(r'\*\*(.*?)\*\*|\*(.*?)\*');
    int currentPosition = 0;

    for (final Match match in pattern.allMatches(text)) {
      // マッチの前のテキストを追加
      if (match.start > currentPosition) {
        spans.add(TextSpan(
          text: text.substring(currentPosition, match.start),
        ));
      }

      // **で囲まれたテキスト（見出し）
      if (match.group(1) != null) {
        spans.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ));
      }
      // *で囲まれたテキスト（項目）
      else if (match.group(2) != null) {
        spans.add(TextSpan(
          text: match.group(2),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ));
      }

      currentPosition = match.end;
    }

    // 残りのテキストを追加
    if (currentPosition < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentPosition),
      ));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const Center(
                  child: Text(
                    'My Concierge',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: _response != null
                          ? _buildFormattedText(_response!)
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'My Conciergeに色々聞いてみましょう',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                    ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _askQuestion,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
