import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/util/constants/routes.dart';
import 'package:notes_app/core/util/constants/spacing.dart';
import 'package:notes_app/core/util/cubit/home_cubit.dart';
import 'package:notes_app/core/util/cubit/home_states.dart';
import 'package:notes_app/core/util/extensions/context_extension.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      return homeCubit.notes.isNotEmpty
          ? ListView.separated(
              itemCount: homeCubit.notes.length,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              separatorBuilder: (_, __) => verticalSpace12,
              itemBuilder: (context, index) {
                final note = homeCubit.notes[index];

                return InkWell(
                  onTap: () {
                    context.push(
                      Routes.editNoteWidget,
                      arguments: note,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade100,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.4),
                          blurRadius: 0.4,
                          spreadRadius: 0.4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            note.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      content: Text(
                                        'هل أنت متأكد من رغبتك في حذف هذه الملاحظة؟',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      actionsAlignment: MainAxisAlignment.start,
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: Text('كلا'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            homeCubit.deleteUser(note.id!);
                                            context.pop();
                                          },
                                          child: Text(
                                            ' نعم',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 16,
                            ),
                          ),
                        ),

                        Text(
                          DateFormat().format(note.createdAt!),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'لا توجد ملاحظات حتى الآن',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
            );
    });
  }
}
