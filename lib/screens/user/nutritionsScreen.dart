import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Child {
  final String age;
  final String title;
  final String nutrition;

  Child({required this.age, required this.title, required this.nutrition});
}

class NutritionsScreen extends StatefulWidget {
  @override
  State<NutritionsScreen> createState() => _NutritionsScreenState();
}

class _NutritionsScreenState extends State<NutritionsScreen> {
  Child child = Child(age: "", title: "", nutrition: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Child Nutrition'),
          backgroundColor: Colors.tealAccent.shade700,
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/IMG-20230607-WA0045.jpg",),fit: BoxFit.cover,opacity: 0.1),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<Child>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Child Age',
                    ),
                    items: children.map((Child child) {
                      return DropdownMenuItem<Child>(
                        value: child,
                        child: Text(child.age),
                      );
                    }).toList(),
                    onChanged: (Child? selectedChild) {
                      setState(() {
                        child = selectedChild!;
                      });
                    },
                  ),
                ),
                Column(
                  children: [
                    Text(
                      child.title,
                      style: GoogleFonts.lato(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        child.nutrition,
                        style: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  final List<Child> children = [
    Child(
      age: 'Birth to 1 Month',
      title: 'Birth to Month 1',
      nutrition: "1. Breast milk or formula feeding on demand.\n\n2. During the first month of life, your baby's main source of nutrition is breast milk or formula.\n\n3. It is important to feed your baby on demand, following their hunger cues.\n\n4. Newborns typically feed every 2-3 hours, but they may have shorter or longer intervals between feedings.\n\n5. Breast milk or formula provides all the essential nutrients your baby needs for growth and development during this period.\n\nIf you have any concerns about feeding or your baby's growth, consult with a healthcare professional.",
    ),
    Child(
      age: '1 to 2 Months',
      title: 'Month 1 to 2',
      nutrition: "1. Breast milk or infant formula is the sole source of nutrition for infants at this age.\n\n2. Feed on demand, typically 8-12 times per day, or as per the baby's cues.\n\n3. It's important to ensure the baby is getting enough milk by monitoring their wet diapers and weight gain.\n\n4. Consult with a healthcare professional for any concerns or questions regarding feeding and growth.",
    ),
    Child(
      age: '2 to 3 Months',
      title: 'Month 2 to 3',
      nutrition: "1. Continue breastfeeding or providing formula on demand.\n\n2.If advised by a healthcare professional, you can introduce a vitamin D supplement for breastfed infants.\n\n3. There's no need for solid foods or water at this stage.",
    ),
    Child(
      age: '3 to 4 Months',
      title: 'Month 3 to 4',
      nutrition: '1. Continue with breast milk or formula on demand.\n\n2. Some infants may start showing signs of readiness for solid foods, but it is generally recommended to wait until around 6 months of age to introduce them. Discuss with a healthcare professional before introducing solids.',
    ),
    Child(
      age: '4 to 5 Months',
      title: 'Month 4 to 5',
      nutrition: '1. Continue breastfeeding or providing formula on demand.\n\n2. Consult with a healthcare professional about the readiness for solid foods.\n\n3. If appropriate, you can begin introducing single-grain iron-fortified baby cereals mixed with breast milk or formula.\n\n4. Start with small amounts and gradually increase the consistency and variety of foods.',
    ),
    Child(
      age: '5 to 6 Months',
      title: 'Month 5 to 6',
      nutrition: '1. Continue with breast milk or formula on demand.\n\n2. If you have started solids, continue introducing pureed fruits and vegetables in addition to baby cereals.\n\n3. Offer small tastes of one new food at a time and watch for any signs of allergies or digestive issues.\n\n4. Consult with a healthcare professional for guidance on introducing new foods and potential allergens.',
    ),
    Child(
      age: '6 to 8 Months',
      title: 'Month 6 to 8',
      nutrition: '1. Breast milk or infant formula should continue to be the primary source of nutrition.\n\n2. Introduce solid foods gradually, starting with iron-fortified cereals, pureed fruits (such as bananas, apples, or pears), and vegetables (such as sweet potatoes, carrots, or peas).\n\n3. Begin with small amounts and gradually increase the quantity and variety of foods.',
    ),
    Child(
      age: '9 to 12 Months',
      title: 'Month 9 to 12',
      nutrition: '1. Continue breastfeeding or providing formula.\n\n2. Offer a variety of soft finger foods, such as well-cooked and mashed vegetables, fruits, and protein sources like finely minced or shredded cooked meat, poultry, or legumes.\n\n3 .Introduce whole milk after the first birthday, if appropriate in consultation with a pediatrician.',
    ),
    Child(
      age: '1-2 Year',
      title: 'Year 1 & 2',
      nutrition: '1. Transition to whole milk as the primary source of milk.\n\n2. Offer a variety of foods from all food groups, including fruits, vegetables, whole grains, lean proteins (meat, fish, poultry, eggs, legumes), and healthy fats (avocado, olive oil).\n\n3. Limit sugary foods and drinks and avoid added salt.',
    ),
    Child(
      age: '2-3 Years',
      title: 'Year 2 & 3',
      nutrition: '1. Continue offering a balanced diet with foods from all food groups.\n\n2. Encourage self-feeding and provide a variety of textures.Introduce low-fat or reduced-fat dairy products if there are no concerns about adequate growth.',
    ),
    Child(
      age: '4-5 Years',
      title: 'Year 4 & 5',
      nutrition: '1. Offer three balanced meals and two to three nutritious snacks throughout the day.\n\n2. Include a variety of foods rich in nutrients, such as whole grains, lean proteins, fruits, vegetables, and low-fat dairy products.\n\n3. Encourage drinking plenty of water and limit sugary beverages.\n\n4. Continue to promote healthy eating habits and provide age-appropriate portion sizes.',
    ),
  ];
}
