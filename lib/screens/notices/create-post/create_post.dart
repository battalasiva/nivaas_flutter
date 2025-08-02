import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/notices/create-post/bloc/create_post_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import '../../../core/constants/img_consts.dart';

class CreatePost extends StatefulWidget {
  final int? apartmentId;
  final int? noticeId;
  final String? title;
  final String? message;
  final String? type;
  final bool? isAdmin,isLeftSelected,isOwner;

  const CreatePost({
    super.key,
    this.apartmentId,
    this.noticeId,
    this.title,
    this.message,
    this.type,
    this.isAdmin,
    this.isLeftSelected,
    this.isOwner,
  });

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String name = 'Manoj d';
  String flatno = 'B 2345';
  final List<String> users = ['All residents', 'Admin', 'user1', 'user2'];
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  String? selectedUser;
  String? _attachedFileName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _msgController.text = widget.message ?? '';
    _titleController.text = widget.title ?? '';
    selectedUser = users[0];
  }

  @override
  void dispose() {
    _msgController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _attachedFileName = result.files.single.name;
      });
    }
  }

  void _onShareOrEditPostButtonPressed() {
    if (!widget.isLeftSelected! && widget.isAdmin!) {
      if (_titleController.text.isEmpty || _msgController.text.isEmpty) {
        CustomSnackbarWidget(
            context: context,
            title: "Title and Message are required",
            backgroundColor: AppColor.red);
        return;
      }

      setState(() {
        _isLoading = true;
      });

      if (widget.type == "CREATE_NOTICE") {
        context.read<CreatePostBloc>().add(
              CreatePostRequested(
                title: _titleController.text,
                body: _msgController.text,
                apartmentId: widget.apartmentId!,
              ),
            );
      } else if (widget.type == "EDIT_NOTICE") {
        context.read<CreatePostBloc>().add(
              EditNotice(widget.noticeId!, _titleController.text,
                  _msgController.text, widget.apartmentId!),
            );
      }
    } else {
      CustomSnackbarWidget(
        context: context,
        title: "You don't have access to edit",
        backgroundColor: AppColor.orange,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(
        title: widget.type == "CREATE_NOTICE" ? 'New Post' : 'Edit Notice',
      ),
      body: BlocListener<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state is CreatePostSuccess || state is EditNoticeLoaded) {
            setState(() {
              _isLoading = false;
            });
            CustomSnackbarWidget(
                context: context,
                title: state is EditNoticeLoaded
                    ? 'Post successfully updated!'
                    : 'Post successfully shared!',
                backgroundColor: AppColor.green);
            Navigator.of(context).pop(true);
          } else if (state is CreatePostFailure) {
            setState(() {
              _isLoading = false;
            });
            CustomSnackbarWidget(
                context: context,
                title: 'Failed tp Process Your request...',
                backgroundColor: AppColor.red);
          }
        },
        child: Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   height: getHeight(context) * 0.1,
            //   color: AppColor.blueShade,
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.max,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const CircleAvatar(
            //           radius: 25,
            //           foregroundImage: AssetImage(profile),
            //         ),
            //         const SizedBox(width: 20),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [Text(name), Text(flatno)],
            //         ),
            //         const SizedBox(width: 25),
            //         Expanded(
            //           child: DropdownButtonFormField<String>(
            //             decoration: InputDecoration(
            //               border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(6)),
            //               contentPadding: const EdgeInsets.symmetric(
            //                   horizontal: 8, vertical: 6),
            //             ),
            //             value: selectedUser,
            //             items: users.map((String user) {
            //               return DropdownMenuItem(
            //                   value: user,
            //                   child: Text(
            //                     user,
            //                     style:
            //                         txt_11_500.copyWith(color: AppColor.black2),
            //                   ));
            //             }).toList(),
            //             onChanged: (String? userSelected) {
            //               setState(() {
            //                 selectedUser = userSelected;
            //               });
            //             },
            //             icon: Icon(
            //               Icons.keyboard_arrow_down,
            //               color: AppColor.black2,
            //             ),
            //             isDense: true,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: txt_14_600.copyWith(color: AppColor.black2),
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyBorder,
                        ),
                      ),
                      hintText: 'Enter Title',
                      hintStyle: txt_14_500.copyWith(color: AppColor.grey),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                    enabled: widget.type != "EDIT_NOTICE",
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Post About',
                    style: txt_14_600.copyWith(color: AppColor.black2),
                  ),
                  Container(
                    height: getHeight(context) * 0.22,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 0.8, color: AppColor.greyBorder)),
                    child: Stack(
                      children: [
                        TextField(
                          controller: _msgController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Describe Here..........',
                              labelStyle: txt_11_500.copyWith(
                                  color: AppColor.greyText2),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15)),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
                        // Positioned(
                        //     bottom: 0,
                        //     right: 0,
                        //     left: 0,
                        //     child: GestureDetector(
                        //       onTap: _pickFile,
                        //       child: Container(
                        //         width: double.infinity,
                        //         padding: const EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           color: AppColor.blueShade,
                        //         ),
                        //         child: Center(
                        //             child: Text(
                        //           'Add Attach',
                        //           style: txt_11_500.copyWith(
                        //               color: AppColor.black2),
                        //         )),
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_attachedFileName != null) ...[
              const SizedBox(height: 10),
              Text(
                'Attached File: $_attachedFileName',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AppColor.white,
                padding: const EdgeInsets.only(bottom: 50,left: 20,right: 20),
                child: CustomizedButton(
                  label: _isLoading
                      ? (widget.type == "CREATE_NOTICE"
                          ? 'Sharing...'
                          : 'Updating...')
                      : (widget.type == "CREATE_NOTICE"
                          ? 'Share Post'
                          : 'Update Post'),
                  style: txt_14_500.copyWith(color: AppColor.white),
                  onPressed: _isLoading
                      ? () {}
                      : () => _onShareOrEditPostButtonPressed(),
                  isReadOnly: widget.isLeftSelected! || !widget.isAdmin! ? true : false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
