import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/home.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/Ui/widgets/imageContainerGenerationScreen.dart';
import 'package:imagineai/firebaseServices/image_sevice.dart';
import 'package:imagineai/utils/utils.dart';

class Finalize extends StatefulWidget {
  final String generatedText;
  final List<Uint8List?> selectedImageData;

  const Finalize(this.generatedText, {super.key, required this.selectedImageData});

  @override
  State<Finalize> createState() => _FinalizeState();
}

class _FinalizeState extends State<Finalize> {
  late ScrollController _scrollController;
  bool _showPrompt = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController tittleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finalize',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children:
                      List.generate(widget.selectedImageData.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ImageContainer(
                        widget.selectedImageData[index],
                        false, // Assuming images are not loading
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Add Tittle',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '(Optional)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade300
                            : customDarkTextContainer,
                        borderRadius: BorderRadius.circular(
                            10), // Customize border radius
                      ),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: tittleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a title!!!';
                                  }

                                  return null;
                                },
                                maxLines: null,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      20, // You can adjust the font size as needed
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add title...',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Publish prompt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Transform.scale(
                          scale: 1.2,
                          child: Switch(
                            value: _showPrompt,
                            onChanged: (bool value) {
                              setState(() {
                                _showPrompt = value;
                              });
                            },
                            activeColor: customPurple,
                            inactiveTrackColor: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade300
                            : customDarkTextContainer,
                        borderRadius: BorderRadius.circular(
                            10), // Customize border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.generatedText,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () async {
                                await downloadImage(context: context);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 0),
                              ),
                              child: const Text(
                                'Download',
                                style: TextStyle(
                                  color: customPurple,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () {
                                Utils().greytoastmsg('This option will be available soon.', context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: customPurple,
                                minimumSize: const Size(double.infinity, 0),
                              ),
                              child: const Center(
                                child: Text(
                                  'Save in profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadImage({required BuildContext context}) async {
    final List<Uint8List?> selectedImageData = widget.selectedImageData;

    ImageQueryService imageQueryService = ImageQueryService();

    await imageQueryService.downloadImage(
      context: context,
      selectedImageData: selectedImageData,
    );

    _showDownloadConfirmationPopup(context);
  }

  void _showDownloadConfirmationPopup(BuildContext context) {

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                width: 150, // Set your desired width
                height: 150, // Set your desired height
                child: Image.asset('assets/material/icons/done.png'),
              ),
                const Text(
                  'Download Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: customPurple),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text(
                    'Your image is downloaded successfully. Now you can view it in your gallery.',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 0),
                          ),
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                              color: customPurple,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Utils().pushReplaceSlideTransition(
                                context, const Home());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customPurple,
                            minimumSize: const Size(double.infinity, 0),
                          ),
                          child: const Center(
                            child: Text(
                              'Back to Home',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

              ],
            ),
          ),
        );
      },
    );
  }
}
