part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  String profilePath = '';
  bool isDataEdited = false;
  File? profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture ?? '';
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToProfilePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Text(
                        "Edit Your\nProfile",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 22, bottom: 10),
                        width: 90,
                        height: 104,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: (profileImageFile != null)
                                      ? FileImage(profileImageFile!)
                                      : (profilePath.isNotEmpty)
                                          ? NetworkImage(profilePath)
                                              as ImageProvider
                                          : const AssetImage(
                                              "assets/user_pic.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (profilePath.isEmpty) {
                                    profileImageFile = await getImage();
                                    if (profileImageFile != null) {
                                      profilePath =
                                          basename(profileImageFile!.path);
                                    }
                                  } else {
                                    profileImageFile = null;
                                    profilePath = '';
                                  }

                                  setState(() {
                                    isDataEdited =
                                        (nameController.text.trim() !=
                                                widget.user.name ||
                                            profilePath !=
                                                widget.user.profilePicture);
                                  });
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(profilePath.isEmpty
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png"),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(text: widget.user.id),
                        style: whiteNumberFont.copyWith(color: accentColor3),
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "User ID",
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller:
                            TextEditingController(text: widget.user.email),
                        style: greyTextFont,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Email Address",
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: nameController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (text.trim() != widget.user.name ||
                                profilePath != widget.user.profilePicture);
                          });
                        },
                        style: blackTextFont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Full Name",
                          hintText: "Full Name",
                        ),
                      ),
                      const SizedBox(height: 46),
                      if (isUpdating)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDataEdited
                                ? const Color(0xFF3E9D9D)
                                : const Color(0xFFE4E4E4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: isDataEdited
                              ? () async {
                                  setState(() {
                                    isUpdating = true;
                                  });

                                  if (profileImageFile != null) {
                                    profilePath =
                                        await uploadImage(profileImageFile!);
                                  }

                                  context.read<UserBloc>().add(UpdateData(
                                      name: nameController.text,
                                      profilePicture: profilePath));

                                  context
                                      .read<PageBloc>()
                                      .add(GoToProfilePage());
                                }
                              : null,
                          child: Text(
                            "Update My Profile",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: defaultMargin),
                child: GestureDetector(
                  onTap: () {
                    context.read<PageBloc>().add(GoToProfilePage());
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFlushbar(BuildContext context, String message) {
    Flushbar(
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: const Color(0xFFFF5C83),
      message: message,
    ).show(context);
  }
}
