import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/repos/project_repository.dart';
import 'package:final_project_mobile/features/proposal/bloc/proposal_bloc.dart';
import 'package:final_project_mobile/features/proposal/repos/proposal_repository.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/features/user/repos/user_repository.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            proposalRepository: ProposalRepository(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        navigatorKey: Routes.mainNavigatorKey,
        onGenerateRoute: Routes.generateRoute,
        home: const Scaffold(
          appBar: CustomAppBar(),
          body: HomePage(),
        ),
      ),
    );
  }
}
