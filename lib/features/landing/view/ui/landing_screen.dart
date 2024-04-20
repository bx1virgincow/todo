import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/features/landing/data/local/local_note_repo_impl.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

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
                Row(
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
                SizedBox(height: 10),
                //search field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: AppColor.textFieldBgColor,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.textFieldTextColor,
                    ),
                    hintText: 'Search by keyword',
                    hintStyle: TextStyle(color: AppColor.textFieldTextColor),
                    suffix: Icon(
                      Icons.filter_list,
                      color: AppColor.textFieldTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //switch container
                Container(
                  height: 45,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text('Tab 1'),
                      ),
                      Tab(
                        child: Text('Tab 2'),
                      ),
                    ],
                  ),
                ),

                //tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(
                        child: Text('Tab 1 View'),
                      ),
                      Center(
                        child: Text('Tab 2 View'),
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

// SafeArea(
// child: BlocConsumer<NoteBloc, NoteState>(
// bloc: _noteBloc,
// builder: (context, state) {
// if (state is NoteInitial) {
// return const Center(child: CircularProgressIndicator());
// } else if (state is NoteLoadedState) {
// return StaggeredGridView.countBuilder(
// crossAxisCount: 4,
// itemCount: state.noteList.length,
// itemBuilder: (BuildContext context, int index) => NoteTile(
// todo: state.noteList[index],
// onDelete: () {
// _noteBloc
//     .add(OnDeleteNoteEvent(state.noteList[index].id));
// }),
// staggeredTileBuilder: (int index) =>
// StaggeredTile.count(2, index.isEven ? 2 : 1),
// mainAxisSpacing: 4.0,
// crossAxisSpacing: 4.0,
// );
// } else if (state is NoteFailedState) {
// return const Text('Failed to fetch data');
// } else {
// return const SizedBox();
// }
// },
// listener: (BuildContext context, NoteState state) {
// if (state is NoteDeletedState) {
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(
// content: Text('Deleted Successfully!'),
// backgroundColor: AppColor.backgroundColor),
// );
// }
// },
// ),
// ),
