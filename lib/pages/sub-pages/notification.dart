import 'package:final_project_mobile/features/default/bloc/default_bloc.dart';
import 'package:final_project_mobile/features/default/bloc/default_event.dart';
import 'package:final_project_mobile/features/notification/bloc/notification_bloc.dart';
import 'package:final_project_mobile/features/notification/bloc/notification_event.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, String>> notifications = [
    {
      'content': 'You have submitted to join project "Javis - AI Copilot"',
      'type': 'notification',
      'id': '1',
      'date': '2024-05-08'
    },
    {
      'content':
          'You have invited to interview for project "Javis - AI Copilot"',
      'type': 'interview',
      'id': '2',
      'date': '2024-05-08'
    },
    {
      'content': 'You have offered to join project "Javis - AI Copilot"',
      'type': 'offer',
      'id': '3',
      'date': '2024-05-08'
    },
    {
      'content': 'New message from Ngoc',
      'type': 'message',
      'id': '4',
      'date': '2024-05-08'
    },
  ];

  List<Map<String, String>> filterednotifications = [];
  final TextEditingController searchController = TextEditingController();
  UserProfileState? userProfileState;
  late int userId;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(GetUserProfile());
    filterednotifications = notifications;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileLoadSuccess) {
          log('userProfileState: $state');
          setState(() {
            userProfileState = state;
            log('userProfileState: $userProfileState');
            userId = state.userProfile.id;
            log('userId: $userId');
            BlocProvider.of<NotificationBloc>(context)
                .add(GetNotification(userId: userId));
          });
        }
      },
      builder: (context, state) {
        if (state is UserProfileLoadSuccess) {
          // if (state is UserProfileLoadSuccess && userProfileState != null) {
          return BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is GetNotificationSuccess) {
                  log('NOTIFICATION: ${state.notifications}');
                  log('GET NOTIFICATION SUCCESS');
                  setState(() {
                    // Set notification
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemCount: filterednotifications.length,
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.grey),
                          itemBuilder: (context, index) {
                            String formattedDate = DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(
                                    filterednotifications[index]['date']!));

                            return ListTile(
                              leading: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue[800],
                                child: Icon(
                                  filterednotifications[index]['type'] ==
                                          'notification'
                                      ? Icons.notification_important
                                      : filterednotifications[index]['type'] ==
                                              'interview'
                                          ? Icons.calendar_today
                                          : filterednotifications[index]
                                                      ['type'] ==
                                                  'offer'
                                              ? Icons.assignment
                                              : Icons.mail,
                                  color: Colors.white,
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                    filterednotifications[index]['content']!,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                              subtitle: Text(formattedDate!),
                              onTap: () {
                                // Navigate to the message details page
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MessageDetailsPage(message: filterednotifications[index]),
                                //   ),
                                // );
                              },
                            );
                          }),
                    )
                  ],
                ),
              ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
