import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category_model.dart';
import 'package:flutter_application_1/models/diet_model.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: colDesign(customTextField()),
        ));
  }

  Column colDesign(TextField customTextField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 30, bottom: 40),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0)
          ]),
          child: customTextField,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text('Category',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 40),
        categoriesSection(120, Colors.transparent),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text('Recomendations for Diets',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 40),
        dietsSection(240, Colors.transparent),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text('Popular',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 40),
        popDietsSection(Colors.transparent)
      ],
    );
  }

  Container categoriesSection(double height, Color color) {
    return Container(
      height: height,
      color: color,
      child: ListView.separated(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => SizedBox(
                width: 25,
              ),
          itemBuilder: (context, index) {
            return Container(
                width: 100,
                decoration: BoxDecoration(
                    color: categories[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          // adjust size of the icons within the circles
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(categories[index].iconPath),
                        ),
                      ),
                      Text(
                        categories[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ]));
          }),
    );
  }

  TextField customTextField() {
    return TextField(
      
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Padding(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Search.svg')),
            suffixIcon: Padding(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Filter.svg')),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)));
  }

  Container dietsSection(double height, Color color) {
    return Container(
      height: height,
      color: color,
      child: ListView.separated(
          itemCount: popDiets.length, // must be set to
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => SizedBox(
                width: 25,
              ),
          itemBuilder: (context, index) {
            return Container(
                width: 210,
                decoration: BoxDecoration(
                    color: categories[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(diets[index].iconPath),
                        ),
                      ),
                      Text(
                        // Item name
                        diets[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        // item Description
                        diets[index].level +
                            " | " +
                            diets[index].duration +
                            " | " +
                            diets[index].calorie,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      Container(
                        height: 45,
                        width: 130,
                        child: Center(
                            child: Text(
                          "View",
                          style: TextStyle(
                            fontSize: 14,
                            color: diets[index].viewIsSelected
                                ? Colors.white
                                : Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            diets[index].viewIsSelected
                                ? Colors.blue
                                : Colors.transparent,
                            diets[index].viewIsSelected
                                ? Colors.purple
                                : Colors.transparent
                          ]),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    ]));
          }),
    );
  }

  Container popDietsSection(Color color) {
    return Container(
      color: color,
      child: ListView.separated(
          itemCount: popDiets.length, // must be set to
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => SizedBox(height: 25),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 40,
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Padding(
                          //Picture
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(popDiets[index].iconPath),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            // Item name
                            popDiets[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            // item Description
                            popDiets[index].level +
                                " | " +
                                popDiets[index].duration +
                                " | " +
                                popDiets[index].calorie,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                  "./assets/icons/button.svg")))
                    ]));
          }),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Breakfast',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white, //search bar
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset("assets/icons/Arrow - Left 2.svg",
              height: 20, width: 20),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            height: 37,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(10)),
            child:
                SvgPicture.asset("assets/icons/dots.svg", height: 5, width: 5),
          ),
        ),
      ],
    );
  }
}
