import 'package:badword_guard/badword_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imagineai/Ui/app_screens/crud.dart';
import 'package:imagineai/Ui/app_screens/imageGeneration.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/Ui/widgets/home_ImagePlaceHolder.dart';
import 'package:imagineai/Ui/widgets/numberPicker.dart';
import 'package:imagineai/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  final TextEditingController promptController = TextEditingController();
  List<Map<String, dynamic>> imagePlaceholderData = [
    {
      'assetPath': 'assets/material/cards place holders/cyberpunk.jpeg',
      'backText': 'Cyberpunk',
    },
    {
      'assetPath': 'assets/material/cards place holders/colorful.jpeg',
      'backText': 'Colorful',
    },
    {
      'assetPath': 'assets/material/cards place holders/robot.jpeg',
      'backText': 'Robotic',
    },
    {
      'assetPath': 'assets/material/cards place holders/realistic.jpeg',
      'backText': 'Realistic',
    },
    {
      'assetPath': 'assets/material/cards place holders/artistic.jpeg',
      'backText': 'Artistic',
    },
  ];
  late ScrollController _scrollController;
  List<String> selectedBackTexts = [];
  late int variations = 4;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/Imagine Ai purple transparent logo.png',
                  width: 30,
                  height: 30,
                ),
                const Text(
                  'Imagine Ai',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Utils().pushSlideTransition(context, crud());
                  },
                  child: Icon(
                    Icons.notifications_none_outlined,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? customDarkTextColor
                        : customLightTextColor,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter Prompt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: const Row(
                    children: [
                      Text(
                        'Explore Prompts',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: customPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_right,
                      color: customPurple,)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: SizedBox(
                height: 200.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? customLightTextContainer
                        : customDarkTextContainer,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: TextFormField(
                          controller: promptController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a prompt';
                            }

                            final LanguageChecker checker = LanguageChecker();
                            bool containsBadWord = checker.containsBadLanguage(value);

                            if (containsBadWord) {
                              return 'Please refrain from using inappropriate prompts!!!';
                            }
                            return null;
                          },
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type anything...',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[300]
                                : Colors.grey[800],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                                onTap: (){
                                  promptController.clear();
                                },
                                child: const Text('Clear text',style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),)),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomNumberPicker(
              value: variations, // initial value
              minValue: 1,
              maxValue: 10,
              step: 1,
              itemHeight: 60,
              axis: Axis.horizontal,
              onChanged: (value) {
                variations = value;
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'Image Style',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
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
                GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(
                      _scrollController.position.extentAfter,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: const Icon(
                    Icons.compare_arrows,
                    color: customPurple,
                    size: 25,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 170,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: imagePlaceholderData.length,
                itemBuilder: (context, index) {
                  final data = imagePlaceholderData[index];
                  final isSelected =
                      selectedBackTexts.contains(data['backText']);
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ImagePlaceholderItem(
                      assetPath: data['assetPath'],
                      backText: data['backText'],
                      initialSelectedState: isSelected,
                      onBackTextChanged: (String backtext, bool isSelected) {
                        setState(() {
                          if (isSelected) {
                            if (!selectedBackTexts.contains(backtext)) {
                              selectedBackTexts.add(backtext);
                            }
                          } else {
                            selectedBackTexts.remove(backtext);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  if (await _formKey.currentState!.validate()) {
                    String promptText = promptController.text.trim();
                    String generatedText = promptText.isNotEmpty
                        ? "$promptText ${selectedBackTexts.join(" ")}"
                        : selectedBackTexts.join(" ");
                    Utils().pushSlideTransition(context, ImageGeneration(
                      generatedText,
                      variations: variations,
                    ),);
                    setState(() {
                      loading = false;
                    });
                  }
                  else{
                    setState(() {
                      loading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: customPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: loading
                    ? const SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Generate',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
