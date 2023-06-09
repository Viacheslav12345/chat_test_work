import 'package:chat_test_work/common/const.dart';
import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:chat_test_work/presentation/pages/chat_screen.dart';
import 'package:chat_test_work/presentation/widgets/add_image.dart';
import 'package:chat_test_work/presentation/widgets/change_user_info.dart';
import 'package:chat_test_work/presentation/route_transition.dart';
import 'package:chat_test_work/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController chatIdController = TextEditingController();

  bool chatIdConsist = false;
  String chatIdValue = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final infoProvider = Provider.of<InfoProvider>(context, listen: false);
      await infoProvider.getCurrentUser();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    chatIdController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final infoProvider = Provider.of<InfoProvider>(context, listen: false);
    String lastSeen = DateTime.now().millisecondsSinceEpoch.toString();
    infoProvider.currentUser.lastSeen = lastSeen;
    super.didChangeDependencies();
  }

  bool showChangeName = false;
  bool showChangeProfession = false;

  @override
  Widget build(BuildContext context) {
    final infoProvider = Provider.of<InfoProvider>(context);
    double h = MediaQuery.of(context).size.height / baseHeight;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(top: 79 * h, left: 157 * fem),
            child: SizedBox(
              width: 177 * fem,
              height: 48 * h,
              child: Text(
                'Chat App',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 40 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.2125 * ffem / fem,
                  color: const Color(0xff000000),
                ),
              ),
            ),
          ),
          const AvatarWidget(),
          Center(
            child: Padding(
                padding: EdgeInsets.only(top: 16 * h),
                child: Text(
                  'ID: ${context.select((InfoProvider value) => value.currentUser.id).toString()}',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.2125 * ffem / fem,
                    color: const Color(0xff000000),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 87 * h, left: 40 * fem),
            child: SizedBox(
                width: 400 * fem,
                height: 35 * h,
                child: Row(children: [
                  SizedBox(
                      width: 200 * fem,
                      height: 35 * h,
                      child: (infoProvider.currentUser.name == '')
                          ? ChangeUserInfo(
                              'name', infoProvider.currentUser.name)
                          : InkWell(
                              onTap: () => setState(
                                () {
                                  showChangeName = true;
                                  ChangeUserInfo(
                                      'name', infoProvider.currentUser.name);
                                },
                              ),
                              child: (showChangeName == false)
                                  ? Text(
                                      infoProvider.currentUser.name,
                                      textAlign: TextAlign.right,
                                      style: SafeGoogleFont(
                                        'Inter',
                                        decoration: TextDecoration.underline,
                                        fontSize: 30 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125 * ffem / fem,
                                        color: const Color(0xff000000),
                                      ),
                                    )
                                  : ChangeUserInfo(
                                      'name', infoProvider.currentUser.name),
                            )),
                  SizedBox(
                    width: 200 * fem,
                    height: 35 * h,
                    child: (infoProvider.currentUser.profession == '')
                        ? ChangeUserInfo(
                            'profession', infoProvider.currentUser.profession)
                        : InkWell(
                            onTap: () => setState(() {
                                  showChangeProfession = true;
                                  ChangeUserInfo('profession',
                                      infoProvider.currentUser.profession);
                                }),
                            child: (showChangeProfession == false)
                                ? Text(
                                    ' ${infoProvider.currentUser.profession}',
                                    textAlign: TextAlign.left,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      decoration: TextDecoration.underline,
                                      fontSize: 30 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  )
                                : ChangeUserInfo('profession',
                                    infoProvider.currentUser.profession)),
                  ),
                ])),
          ),
          Padding(
            padding: EdgeInsets.only(top: 38 * h, left: 84 * fem),
            child: Container(
              width: 323 * fem,
              height: 66 * h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * fem),
                border: Border.all(color: const Color(0xff000000)),
                color: const Color(0xffffffff),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 23 * h, left: 32 * fem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 123 * fem,
                        height: 24 * h,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter chat id',
                            labelStyle: SafeGoogleFont(
                              'Inter',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                          onChanged: (value) => chatIdValue = value,
                          onSubmitted: (value) async {
                            if (value.isNotEmpty) {
                              chatIdConsist = true;
                              await infoProvider.setIdAndloadInfoForChat(value);
                              goToChat();
                            }
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 19.0),
                      child: GestureDetector(
                        onTap: () async {
                          if (chatIdValue.isNotEmpty) {
                            chatIdConsist = true;
                            await infoProvider
                                .setIdAndloadInfoForChat(chatIdValue);
                            goToChat();
                          }
                        },
                        child: Image.asset(
                          'assets/components/images/paper-airplane.png',
                          width: 24 * fem,
                          height: 24 * h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
        // )
      ),
    );
  }

  void goToChat() {
    if (chatIdConsist) {
      Navigator.of(context).push(
          RouteTransition(page: const ChatScreen(), routeName: '/chatScreen'));
    }
  }
}

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  bool showAddphoto = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / baseHeight;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final currentUserAva =
        context.select((InfoProvider value) => value.currentUser.avatar);

    return Padding(
      padding: EdgeInsets.only(top: 137 * h, left: 137 * fem),
      child: SizedBox(
        width: 216 * fem,
        height: 213 * h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35 * fem),
          child: (showAddphoto == false && currentUserAva == '')
              ? InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg:
                          "Click on avatar once again to set photo from gallery.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 18.0,
                    );
                    setState(() {
                      showAddphoto = true;
                    });
                  },
                  child: Image.asset(
                    'assets/components/images/unknown-user.png',
                    fit: BoxFit.cover,
                  ))
              : InkWell(
                  onTap: () {
                    setState(() {
                      showAddphoto = true;
                    });
                  },
                  child: const AddImage(),
                ),
        ),
      ),
    );
  }
}
