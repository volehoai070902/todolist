import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/views/components/task/model/category_model.dart';

final categoryProvider = StateProvider((ref) => Category.Learning);