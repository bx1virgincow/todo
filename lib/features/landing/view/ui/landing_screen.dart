import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/font.dart';
import 'package:todo/features/landing/data/local/local_note_repo_impl.dart';
import 'package:todo/features/landing/view/widget/note_container.dart';
import 'package:todo/features/landing/view/widget/search_widget.dart';

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
  // initialization of bloc
  final NoteBloc _noteBloc = NoteBloc(LocalNoteRepoImpl());

  // tab bar controller
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _noteBloc.add(OnNoteLoadEvent(noteList: const []));
  }

  // on search changed
  void _onSearchChanged(String query) {
    _noteBloc.add(SearchNoteEvent(searchValue: query));
  }

  // clear search
  void _clearSearch() {
    _searchController.clear();
    _noteBloc.add(SearchNoteEvent(searchValue: ''));
    setState(() {
      _isSearchVisible = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColor.backgroundColor,
            foregroundColor: AppColor.whiteColor,
            label: Text('Add Note'),
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTodo()),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Notes',
                        style: TextStyle(
                          color: AppColor.backgroundColor,
                            fontSize: AppFont.largerFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSearchVisible = !_isSearchVisible;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppColor.backgroundColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.search_outlined,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Search field
                  _isSearchVisible
                      ? AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeIn,
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            onTapOutside: (e) =>
                                FocusScope.of(context).unfocus(),
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
                              hintStyle: const TextStyle(
                                  color: AppColor.textFieldTextColor),
                              suffixIcon: InkWell(
                                onTap: _clearSearch,
                                child: const Icon(
                                  Icons.close_outlined,
                                  color: AppColor.textFieldTextColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),

                  // Switch container
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

                  // Tab bar view here
                  Flexible(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BlocBuilder<NoteBloc, NoteState>(
                          bloc: _noteBloc,
                          builder: (context, state) {
                            if (state is NoteInitial) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is NoteLoadedState) {
                              return NoteWidget(
                                noteList: state.noteList,
                                noteBloc: _noteBloc,
                              );
                            } else if (state is SearchNoteState) {
                              return SearchWidget(
                                noteList: state.noteList,
                                noteBloc: _noteBloc,
                              );
                            } else if (state is NoteFailedState) {
                              return const Center(
                                  child: Text('Failed to fetch data'));
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        // Other tab
                        const Center(
                          child: Text('Coming soon...'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
