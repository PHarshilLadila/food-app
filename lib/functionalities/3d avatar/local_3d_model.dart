import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/functionalities/3d%20avatar/shader%20and%20fragment/shader_widget.dart';
import 'package:food_app/functionalities/3d%20avatar/shader%20and%20fragment/widget/shader_widget_one.dart';
import 'package:food_app/functionalities/3d%20avatar/shader%20and%20fragment/widget/shader_widget_three.dart';
import 'package:food_app/functionalities/3d%20avatar/shader%20and%20fragment/widget/shader_widget_two.dart';

import 'package:o3d/o3d.dart';

class Local3dModel extends StatefulWidget {
  final String? threeDImageUrl;
  const Local3dModel({super.key, this.threeDImageUrl});

  @override
  State<Local3dModel> createState() => _Local3dModelState();
}

class _Local3dModelState extends State<Local3dModel> {
  final O3DController controller = O3DController();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    widget.threeDImageUrl;
  }

  int _index = 0;

  final List _pages = [
    () => ShaderWidget(),
    () => ShaderWidgetOne(),
    () => ShaderWidgetTwo(),
    () => ShaderWidgetThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("3D Model"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: _pages[_index](),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 244, 255, 244),
              icon: FaIcon(
                FontAwesomeIcons.one,
                size: 15,
              ),
              label: 'BackGround'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.two,
                size: 15,
              ),
              label: 'BackGround'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.three,
                size: 15,
              ),
              label: 'BackGround'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.four,
                size: 15,
              ),
              label: 'BackGround'),
        ],
      ),
    );
  }
}
