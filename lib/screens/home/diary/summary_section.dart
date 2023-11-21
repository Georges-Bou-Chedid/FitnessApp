import 'package:fitnessapp/widgets/summary_pie_chart.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  SummaryPageState createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  List<Item> items = [
    Item('Calories', 'Calories are a measure of the energy that food and drinks provide when consumed. They play a crucial role in fueling our body`s functions and physical activities. Balancing calorie intake with expenditure is essential for managing body weight and overall health.', Image.asset('assets/images/svg/calories.png', width: 30, height: 30)),
    Item('Protein', 'Protein is a crucial macronutrient essential for cell growth and repair. It supports muscle development, boosts the immune system, and aids in enzyme production. You can find protein in foods like meat, dairy, legumes, and nuts for a balanced diet.', Image.asset('assets/images/svg/protein.png', width: 30, height: 30)),
    Item('Carbohydrate', 'Carbohydrates, known as carbs, are essential nutrients providing the bod`s primary energy source. They exist in various forms, including sugars, starches, and fiber. Optimal carbohydrate intake from whole foods supports energy, blood sugar balance, and overall health.', Image.asset('assets/images/svg/carbohydrate.png', width: 30, height: 30)),
    Item('Fiber', 'Fiber, a plant-based carbohydrate, is essential for digestive health. It helps maintain regular bowel movements and supports overall well-being. Consuming an adequate amount of fiber-rich foods is key to a balanced diet.', Image.asset('assets/images/svg/fiber.png', width: 30, height: 30)),
    Item('Sugar', 'Sugar, a simple carbohydrate, provides a quick source of energy but should be consumed in moderation. Excessive sugar intake can lead to health issues, such as weight gain and dental problems. A balanced diet includes naturally occurring sugars found in fruits, and it`s advisable to limit added sugars from processed foods and sugary beverages.', Image.asset('assets/images/svg/sugar.png', width: 30, height: 30)),
    Item('Fat', 'Fat is an essential nutrient vital for various bodily functions. It`s found in different foods, including both healthy sources like avocados and nuts, and less healthy sources like fried foods. Balancing fat intake is crucial, as excessive consumption can lead to weight gain and health problems. Incorporating unsaturated fats, such as those found in olive oil and fatty fish, is a healthier choice for overall well-being.', Image.asset('assets/images/svg/fat.png', width: 30, height: 30)),
    Item('Saturated Fat', 'Saturated fat is commonly found in animal products and some plant-based oils. Consuming it in moderation is essential for overall health, while excessive intake may increase the risk of heart disease. Opt for lean meats and unsaturated fats for a balanced diet.', Image.asset('assets/images/svg/saturatedfat.png', width: 30, height: 30)),
    Item('Polyunsaturated Fat', 'Polyunsaturated fats, found in foods like fatty fish, nuts, and seeds, are essential for a healthy diet. These fats, divided into omega-3 and omega-6 categories, promote heart health by reducing bad cholesterol levels. Additionally, omega-3 polyunsaturated fats support brain function and may help lower the risk of neurological disorders.', Image.asset('assets/images/svg/polyunsaturatedfat.png', width: 30, height: 30)),
    Item('Monounsaturated Fat', 'Monounsaturated fats, abundant in olive oil, avocados, and nuts, are a heart-healthy choice. These fats can help lower bad cholesterol levels and reduce the risk of heart disease. They also provide essential nutrients and support overall well-being.', Image.asset('assets/images/svg/monounsaturatedfat.png', width: 30, height: 30)),
    Item('Trans Fat', 'Trans fats, often found in processed and fried foods, are harmful to health. These artificial fats can raise bad cholesterol levels and increase the risk of heart disease. Avoiding trans fats is crucial for maintaining a healthy diet and reducing the likelihood of cardiovascular issues.', Image.asset('assets/images/svg/transfat.png', width: 30, height: 30)),
    Item('Cholesterol', 'Cholesterol is a waxy, fat-like substance that your body needs for various functions. However, too much "bad" cholesterol, or low-density lipoprotein (LDL), can increase the risk of heart disease. It`s essential to manage your cholesterol levels through a balanced diet and a healthy lifestyle to support overall heart health.', Image.asset('assets/images/svg/cholesterol.png', width: 30, height: 30)),
    Item('Sodium', 'Sodium is an essential mineral that helps regulate bodily functions. However, excessive sodium intake, often found in processed foods, can contribute to high blood pressure and related health issues. Maintaining a balanced diet with limited sodium can support overall heart and kidney health.', Image.asset('assets/images/svg/sodium.png', width: 30, height: 30)),
    Item('Potassium', 'Potassium is a crucial mineral that aids in muscle function and heart health. It helps maintain proper blood pressure and fluid balance in the body. Including potassium-rich foods, like bananas and sweet potatoes, in your diet can promote overall well-being and lower the risk of certain health concerns.', Image.asset('assets/images/svg/potassium.png', width: 30, height: 30)),
    Item('Vitamin A', 'Vitamin A is an essential nutrient that supports healthy vision, immune function, and skin health. It`s found in foods like carrots, spinach, and sweet potatoes. Ensuring an adequate intake of vitamin A can help protect your eyes, boost your immune system, and promote radiant skin.', Image.asset('assets/images/svg/vitamin.png', width: 30, height: 30)),
    Item('Vitamin C', 'Vitamin C, also known as ascorbic acid, is a powerful antioxidant that helps boost your immune system, supports skin health, and aids in wound healing. It`s abundant in citrus fruits like oranges and strawberries. Ensuring an adequate intake of vitamin C can keep you feeling your best and promote a healthy, glowing complexion.', Image.asset('assets/images/svg/vitamin.png', width: 30, height: 30)),
    Item('Calcium', 'Calcium is an essential mineral vital for strong bones and teeth. It plays a crucial role in muscle function, blood clotting, and nerve transmission. Dairy products like milk and cheese are rich sources of calcium. A balanced intake helps maintain bone density and overall health.', Image.asset('assets/images/svg/calcium.png', width: 30, height: 30)),
    Item('Iron', 'Iron is a vital mineral that plays a key role in transporting oxygen through the bloodstream, promoting energy production, and supporting overall well-being. It`s found in foods like red meat, spinach, and beans. Adequate iron intake helps prevent anemia and keeps you feeling energized.', Image.asset('assets/images/svg/iron.png', width: 30, height: 30))
  ];

  int selectedIndex = -1; // No dropdown expanded by default

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Column(
                  children: items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return Column(
                      children: [
                        if (selectedIndex != index)
                        Container(
                          width: double.infinity, // Full width
                          height: 60, // Set the desired height
                          decoration: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                  color: const Color(0xFFFFFFFF), // Set the border color here
                                  width: 1.0, // Set the border width here
                                ),
                              )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(
                                    color: const Color(0xFF323232), // Set the border color here
                                    width: 1.0, // Set the border width here
                                  ),
                          ),
                          child: ListTile(
                            title: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            trailing: item.image,
                            onTap: () {
                              setState(() {
                                if (selectedIndex == index) {
                                  selectedIndex = -1; // Close the selected dropdown
                                } else {
                                  selectedIndex = index; // Expand the selected dropdown
                                }
                              });
                            },
                          )
                        ),
                        if (selectedIndex == index)
                          Container(
                              width: double.infinity, // Full width
                              height: 60, // Set the desired height
                              decoration: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                                  BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50), // Rounded top-left corner
                                      topRight: Radius.circular(50), // Rounded top-right corner
                                      bottomLeft: Radius.circular(0), // Not rounded on the bottom left
                                      bottomRight: Radius.circular(0), // Not rounded on the bottom right
                                    ),
                                    border: Border.all(
                                      color: const Color(0xFFFFFFFF), // Set the border color here
                                      width: 1.0, // Set the border width here
                                    ),
                                  )
                                  : BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(50), // Rounded top-left corner
                                        topRight: Radius.circular(50), // Rounded top-right corner
                                        bottomLeft: Radius.circular(0), // Not rounded on the bottom left
                                        bottomRight: Radius.circular(0), // Not rounded on the bottom right
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFF323232), // Set the border color here
                                        width: 1.0, // Set the border width here
                                      ),
                              ),
                              child: ListTile(
                                title: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                trailing: item.image,
                                onTap: () {
                                  setState(() {
                                    if (selectedIndex == index) {
                                      selectedIndex = -1; // Close the selected dropdown
                                    } else {
                                      selectedIndex = index; // Expand the selected dropdown
                                    }
                                  });
                                },
                              )
                          ),
                          if (selectedIndex == index)
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                                BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0), // Rounded top-left corner
                                    topRight: Radius.circular(0), // Rounded top-right corner
                                    bottomLeft: Radius.circular(50), // Not rounded on the bottom left
                                    bottomRight: Radius.circular(50), // Not rounded on the bottom right
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFFFFFFFF), // Set the border color here
                                    width: 1.0, // Set the border width here
                                  ),
                                )
                                : BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0), // Rounded top-left corner
                                    topRight: Radius.circular(0), // Rounded top-right corner
                                    bottomLeft: Radius.circular(50), // Not rounded on the bottom left
                                    bottomRight: Radius.circular(50), // Not rounded on the bottom right
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFF323232), // Set the border color here
                                    width: 1.0, // Set the border width here
                                  ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.description,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Inter"
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const SummaryPieChart();
                                        },
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      primary: Colors.blue, // Set the button text color to blue
                                    ),
                                    child: const Text(
                                      "View Chart",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Inter",
                                        color: Color(0xFF5AC8FA), // Set your desired text color
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ),
                ],
              )
              )
            ],
          ),
      );
  }
}

class Item {
  final String title;
  final String description;
  final Image image;

  Item(this.title, this.description, this.image);
}

