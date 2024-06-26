import 'package:final_project_mobile/features/default/bloc/default_bloc.dart';
import 'package:final_project_mobile/features/default/repos/default_repository.dart';
import 'package:final_project_mobile/features/message/bloc/message_bloc.dart';
import 'package:final_project_mobile/features/message/repos/message_repo.dart';
import 'package:final_project_mobile/features/notification/bloc/notification_bloc.dart';
import 'package:final_project_mobile/features/notification/repos/notification_repository.dart';
import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/repos/project_repository.dart';
import 'package:final_project_mobile/features/proposal/bloc/proposal_bloc.dart';
import 'package:final_project_mobile/features/proposal/repos/proposal_repository.dart';
import 'package:final_project_mobile/features/selectRole/bloc/role_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/features/user/repos/user_repository.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserProfileBloc(
            repository: UserRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProjectBloc(
            projectRepository: ProjectRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProposalBloc(
            repository: ProposalRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => DefaultBloc(
            repository: DefaultRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => RoleBloc(),
        ),
        BlocProvider(
          create: (_) => MessageBloc(
            messageRepository: MessageRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => NotificationBloc(
            repository: NotificationRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        navigatorKey: Routes.mainNavigatorKey,
        // routes: Routes.routes,
        onGenerateRoute: Routes.generateRoute,
        home: const Scaffold(
          // appBar: AppBarBack(),
          body: HomePage(),
        ),
      ),
    );
  }
}
