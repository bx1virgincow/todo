import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/landing/data/local/local_note_repo_impl.dart';
import 'package:todo/features/landing/view/widget/note_container.dart';

import '../../../../common/color.dart';
import '../bloc/note_bloc.dart';
import 'add_todo_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  //initilization of bloc
  final NoteBloc _noteBloc = NoteBloc(LocalNoteRepoImpl());

  //tab bar controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _noteBloc.add(OnNoteLoadEvent(noteList: const []));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodo()),
          ),
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //user information and notification row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  color: AppColor.onBoardDescriptionColor),
                            ),
                            Text(
                              'Honya Bright',
                              style:
                                  TextStyle(color: AppColor.onBoardTitleColor),
                            )
                          ],
                        )
                      ],
                    ),
                    //notification

                    CircleAvatar()
                  ],
                ),
                const SizedBox(height: 10),
                //search field
                BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    return TextFormField(
                      onChanged: (value) {
                        context
                            .read<NoteBloc>()
                            .add(SearchNoteEvent(searchValue: value));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fillColor: AppColor.textFieldBgColor,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColor.textFieldTextColor,
                        ),
                        hintText: 'Search by keyword',
                        hintStyle:
                            const TextStyle(color: AppColor.textFieldTextColor),
                        suffixIcon: const Icon(
                          Icons.filter_list,
                          color: AppColor.textFieldTextColor,
                        ),
                      ),
                    );

                  },
                ),
                const SizedBox(height: 10),

                //switch container
                Container(
                  height: 45,
                  decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                        color: AppColor.tabForegroundColor,
                        borderRadius: BorderRadius.circular(15)),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColor.whiteColor,
                    unselectedLabelColor: AppColor.onBoardDescriptionColor,
                    tabs: const [
                      Tab(
                        text: 'Notes',
                      ),
                      Tab(
                        text: 'My Todo\'s',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                //tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      NoteWidget(),
                      Center(
                        child: Text('Coming soon...'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
