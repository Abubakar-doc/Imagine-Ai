import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/crud.dart';
import 'package:imagineai/Ui/themeStyle.dart';
import 'package:imagineai/Ui/widgets/home_ImagePlaceHolder.dart';
import 'package:imagineai/utils/utils.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  final TextEditingController promptController = TextEditingController();

  // List to store data for ImagePlaceholders
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
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
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Prompt',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: SizedBox(
                  height: 200.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: promptController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type anything...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Image Style',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5,),
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
              const SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: imagePlaceholderData.length,
                  itemBuilder: (context, index) {
                    final data = imagePlaceholderData[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ImagePlaceholder(
                        assetPath: data['assetPath'],
                        backText: data['backText'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
