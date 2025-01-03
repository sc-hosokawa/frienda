import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageOfferPage extends ConsumerStatefulWidget {
  final int offerId;
  final String userId;

  const ManageOfferPage({
    super.key,
    required this.offerId,
    required this.userId,
  });

  @override
  ConsumerState<ManageOfferPage> createState() => _ManageOfferPageState();
}

class _ManageOfferPageState extends ConsumerState<ManageOfferPage> {
  String? _selectedUserId;
  bool _isModalVisible = false;
  String _modalType = 'ongoing'; // 'ongoing' or 'finished'

  static const String GET_USERS_IN_OFFER = r'''
    query GetUsersInOffer($offerId: Int!, $userId: String!) {
      getUsersInOffer(offerId: $offerId, userId: $userId) {
        users {
          userId
          username
          imgUrl
          email
          category
          statusInOffer
        }
      }
    }
  ''';

  static const String UPDATE_OFFER_STATUS = r'''
    mutation UpdateOfferStatus($input: UpdateOfferStatusInput!) {
      updateOfferStatus(input: $input) {
        id
        offerId
      }
    }
  ''';

  static const String CREATE_MESSAGE_ROOM = r'''
    mutation CreateNewMessageRoom($input: CreateNewMessageRoomInput!) {
      createNewMessageRoom(input: $input) {
        id
      }
    }
  ''';

  void _showConfirmationDialog({
    required String userId,
    required String type,
    required Function onConfirm,
  }) {
    setState(() {
      _selectedUserId = userId;
      _modalType = type;
      _isModalVisible = true;
    });

    final content = _modalType == 'ongoing'
        ? {
            'title': '依頼の確認',
            'message': 'このユーザーに依頼を送信しますか？',
            'description': '依頼を送信すると、このユーザーとのみ作業を進めることになります。',
            'buttonText': '依頼する',
          }
        : {
            'title': '完了の確認',
            'message': 'この依頼を完了としてよろしいですか？',
            'description': '完了すると、この依頼は終了となります。',
            'buttonText': '完了する',
          };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            content['title']!,
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content['message']!,
                style: TextStyle(color: Colors.grey[300]),
              ),
              SizedBox(height: 8),
              Text(
                content['description']!,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE4DBC0),
              ),
              child: Text(
                content['buttonText']!,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserList(Map<String, dynamic> userData) {
    final users = userData['getUsersInOffer']['users'] as List;
    final ongoingUser = users.firstWhere(
      (user) => user['statusInOffer'] == 'Ongoing',
      orElse: () => null,
    );
    final finishedUser = users.firstWhere(
      (user) => user['statusInOffer'] == 'Finished',
      orElse: () => null,
    );

    if (finishedUser != null) {
      return _buildFinishedState(finishedUser);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offer Management',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        if (ongoingUser != null)
          _buildUserCard(ongoingUser, isOngoing: true)
        else
          ...users.map((user) => _buildUserCard(user)),
      ],
    );
  }

  Widget _buildFinishedState(Map<String, dynamic> finishedUser) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            'このOfferは終了しました',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            '貢献したユーザー',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(finishedUser['imgUrl']),
                radius: 20,
              ),
              SizedBox(width: 8),
              Text(
                finishedUser['username'],
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user, {bool isOngoing = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOngoing ? Colors.black : Colors.grey[900],
        border:
            isOngoing ? Border.all(color: Colors.blue[500]!, width: 1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user['imgUrl']),
            radius: 20,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['username'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user['category'],
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _handleMessageClick(user['userId']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                ),
                child: Text('メッセージ'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => isOngoing
                    ? _handleFinishClick(user['userId'])
                    : _handleRequestClick(user['userId']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE4DBC0),
                ),
                child: Text(
                  isOngoing ? '完了する' : '依頼する',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isOngoing ? Colors.blue[900] : Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  user['statusInOffer'],
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleMessageClick(String targetUserId) {
    // TODO: Implement message room creation and navigation
  }

  void _handleRequestClick(String targetUserId) {
    _showConfirmationDialog(
      userId: targetUserId,
      type: 'ongoing',
      onConfirm: () => _updateOfferStatus(targetUserId, 'Ongoing'),
    );
  }

  void _handleFinishClick(String targetUserId) {
    _showConfirmationDialog(
      userId: targetUserId,
      type: 'finished',
      onConfirm: () => _updateOfferStatus(targetUserId, 'Finished'),
    );
  }

  void _updateOfferStatus(String targetUserId, String status) {
    // TODO: Implement GraphQL mutation for updating offer status
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offer Management'),
        backgroundColor: Colors.black,
      ),
      body: Query(
        options: QueryOptions(
          document: gql(GET_USERS_IN_OFFER),
          variables: {
            'offerId': widget.offerId,
            'userId': widget.userId,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Center(child: Text('エラーが発生しました'));
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: _buildUserList(result.data!),
          );
        },
      ),
    );
  }
}
