class TaskStatus {
  final String title;
  final String value;

  TaskStatus({required this.title, required this.value});
}

List<TaskStatus> taskStatus = [
  TaskStatus(title: 'Active', value: 'active'),
  TaskStatus(title: 'In-Progress', value: 'in-progress'),
  TaskStatus(title: 'Completed', value: 'completed'),
  TaskStatus(title: 'Incomplete', value: 'in-complete'),
];
