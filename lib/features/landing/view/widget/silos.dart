// //switch container
// Container(
// height: 45,
// decoration: const BoxDecoration(
// color: AppColor.whiteColor,
// ),
// child: TabBar(
// controller: _tabController,
// indicator: BoxDecoration(
// color: AppColor.tabForegroundColor,
// borderRadius: BorderRadius.circular(15)),
// indicatorSize: TabBarIndicatorSize.tab,
// labelColor: AppColor.whiteColor,
// unselectedLabelColor: AppColor.onBoardDescriptionColor,
// tabs: const [
// Tab(
// text: 'Notes',
// ),
// Tab(
// text: 'My Todo\'s',
// ),
// ],
// ),
// ),
// const SizedBox(height: 10),
//
// //tab bar view here
// Expanded(
// child: TabBarView(
// controller: _tabController,
// children: [
// BlocBuilder<NoteBloc, NoteState>(
// bloc: _noteBloc,
// builder: (context, state) {
// if (state is NoteInitial) {
// return const Center(
// child: CircularProgressIndicator());
// } else if (state is NoteLoadedState) {
// return NoteWidget(
// noteList: state.noteList,
// noteBloc: _noteBloc,
// );
// } else if (state is SearchNoteState) {
// return SearchWidget(
// noteList: state.noteList,
// noteBloc: _noteBloc,
// );
// } else if (state is NoteFailedState) {
// return const Center(
// child: Text('Failed to fetch data'));
// } else {
// return const SizedBox();
// }
// },
// ),
// //other tab
// const Center(
// child: Text('Coming soon...'),
// )
// ],
// ),
// )