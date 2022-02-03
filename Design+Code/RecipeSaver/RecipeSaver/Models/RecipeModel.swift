//
//  RecipeModel.swift
//  RecipeSaver
//
//  Created by Dara To on 2021-12-23.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case breakfast = "Breakfast"
    case soup = "Soup"
    case salad = "Salad"
    case appetizer = "Appetizer"
    case main = "Main"
    case side = "Side"
    case dessert = "Dessert"
    case snack = "Snack"
    case drink = "Drink"
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let ingredients: String
    let directions: String
    let category: Category.RawValue
    let datePublished: String
    let url: String
}

extension Recipe {
    static let all: [Recipe] = [
        Recipe(
            name: "Creamy Carrot Soup",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98892/Creamy-Carrot-Soup-for-Wordpress-360x270-c.jpg",
            description: "This bold-hued soup is perfectly sweet and seriously comforting. Peeling the red bell pepper helps make this carrot soup extra silky. Dress it up with a drizzle of rich cashew cream, pomegranate seeds, and chopped fresh parsley for a festive fall presentation.",
            ingredients: "¼ cup cashews\n1 medium onion, cut into ½-inch dice (2 cups)\n1½ pounds carrots, cut into ½-inch dice (3½ cups)\n1 red bell pepper, peeled and cut into ½-inch dice (1 cup)\n1 sprig fresh rosemary\n1 sprig fresh thyme\n1 large fresh sage leaf\n4 cloves garlic, minced\n1 tablespoon lemon juice\nSea salt and freshly ground black pepper or cayenne pepper, to taste\n½ cup fresh pomegranate seeds\n2 tablespoons finely chopped fresh parsley",
            directions: "In a small bowl, cover the cashews with ½ cup hot water; let soak 20 minutes. Transfer cashews and remaining liquid to a blender; blend until smooth and creamy. Set aside.\nIn a saucepan, combine onion, carrots, bell pepper, rosemary, thyme, sage, and garlic. Add ½ cup water and sauté over medium heat for 15 to 20 minutes, or until carrots are tender.\nRemove pan from heat. Let vegetables cool for 10 minutes; then remove rosemary sprigs and thyme leaf.\nTransfer sauteed vegetables to a blender, and puree to a smooth paste. Return pureed vegetables to saucepan and add 3 cups water and 1 tablespoon lemon juice. Season with salt and pepper. Bring soup to boiling.\nTo serve, place soup in individual bowls, drizzle with cashew cream, and garnish with pomegranate seeds and parsley.",
            category: "Soup",
            datePublished: "2019-11-11",
            url: "https://www.forksoverknives.com/recipes/vegan-soups-stews/creamy-carrot-soup/"
        ),
        Recipe(
            name: "Kale, Apple, and Quinoa Salad",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98341/Kale-Apple-Quinoa-Salad-wordpress-360x270-c.jpg",
            description: "Each bite of this colorful salad is filled with the flavors of favorite fall ingredients such as apples, butternut squash, and pumpkin seeds. For optimum freshness and texture, wait to add the dressing until just before serving.\n\nNote that this recipe calls for cooked quinoa, so have that ready to go: For 1½ cups cooked quinoa, rinse and drain ½ cup quinoa; cook according to package directions; and drain if needed. Check out our Grains Cooking Guide for more tips on prepping grains like a pro.",
            ingredients: "2 cups ¾-inch pieces peeled butternut squash\n¼ cup pumpkin seeds\n¼ teaspoon ground cinnamon\n1 lemon\n2 tablespoons pure maple syrup\n1 tablespoon Dijon mustard\n3 cups stemmed and chopped kale\n1½ cups cooked quinoa\n1 cup chopped apple\n½ cup sliced green onionsSea salt and freshly ground black pepper, to taste",
            directions: "Preheat oven to 400°F. Line a 15×10-inch baking pan with parchment paper or a silicone baking mat. Arrange squash in the prepared baking pan. Roast 20 to 25 minutes or until squash is tender, brushing lightly with water if squash starts to look dry. Cool slightly on a wire rack.\nMeanwhile, in a small bowl toss together pumpkin seeds and ½ teaspoon water; sprinkle with cinnamon. Place pumpkin seeds in a small, shallow baking pan. Roast 5 minutes or until lightly toasted; cool\nFor dressing, remove 1 teaspoon zest and squeeze 2 tablespoons juice from lemon. In a small bowl whisk together lemon zest and juice, maple syrup, and mustard.\nIn a large bowl combine kale, quinoa, apple, green onions, and roasted squash. Add dressing; toss to coat. Season with salt and pepper. Top with pumpkin seeds.",
            category: "Salad",
            datePublished: "2019-10-22",
            url: "https://www.forksoverknives.com/recipes/vegan-salads-sides/kale-apple-and-quinoa-salad/"
        ),
        Recipe(
            name: "Kale Bruschetta",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/25202/Kale-Bruschetta-WP-360x270-c.jpg",
            description: "We adore this as an appetizer, and so does everyone else. It is always the first empty platter at our holiday party. No one knows it is plant-based; they just know it is so yummy.\nFrom The Prevent and Reverse Heart Disease Cookbook\nThis kale bruschetta recipe is also available in our convenient iPhone app and newly released Android app.",
            ingredients: "1 bunch kale\n1 loaf fresh 100% whole-grain bread, sliced\n½ cup Cannellini Bean Sauce\n1 cup grape tomatoes, halved\nbalsamic glaze",
            directions: "Place the kale leaves in a large pot of boiling water. Cover and cook until tender, about 5 minutes. Drain in a colander, then squeeze out any extra liquid with your hands (you don’t want soggy bread).\nToast 8 pieces of bread, and place them on a handsome serving platter.\nSpread a tablespoon of the Cannellini Bean Sauce on the toasted bread, then cover with a layer of kale and top with a scattering of grape tomatoes. Drizzle\ngenerously with the balsamic glaze, and grab one for yourself before they all disappear.",
            category: "Appetizer",
            datePublished: "2015-06-28",
            url: "https://www.forksoverknives.com/recipes/vegan-snacks-appetizers/kale-bruschetta/"
        ),
        Recipe(
            name: "Vegetable Pot Pie",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98816/Vegetable-pot-pie-for-wordpress-360x270-c.jpg",
            description: "This eye-popping pot pie makes a hearty addition to a holiday menu or an impressive entree any time of year. Note that this recipe calls for whole wheat pizza dough: Make some using our 10-minute recipe or look for oil-free options at the store (Trader Joe’s makes a good one).",
            ingredients: "3 cups sliced fresh cremini mushrooms\n1 cup sliced carrots\n½ cup sliced celery\n3¼ cups low-sodium vegetable broth\n2 cups ½-inch pieces peeled butternut squash\n1½ cups frozen whole pearl onions\n1 teaspoon chopped fresh thyme\n1 bay leaf\n1 15-oz. can no-salt-added chickpeas, rinsed and drained\n1 cup frozen peas\n1 cup frozen corn\n3 tablespoons all-purpose flour\nSea salt and freshly ground black pepper, to taste\n1 recipe Homemade Oil-Free Pizza Dough or 1 lb. refrigerated whole wheat pizza dough\n1 tablespoon unsweetened plant milk, such as almond, soy, cashew, or rice",
            directions: "Preheat oven to 425°F. For filling, in a 4-qt. saucepan cook mushrooms, carrots, and celery over medium 3 to 4 minutes, stirring occasionally and adding water, 1 to 2 Tbsp. at a time, as needed to prevent sticking. Add 3 cups of the broth, the squash, onions, thyme, and bay leaf. Bring to boiling; reduce heat. Simmer, covered, 5 minutes or until vegetables are nearly tender. Stir in chickpeas, peas, and corn.\nWhisk together flour and the remaining ¼ cup broth; stir into vegetables. Cook until thick and bubbly, stirring occasionally. Remove from heat. Remove and discard bay leaf. Season filling with salt and pepper. Spread into a 2½- to 3-qt. round or oval baking dish.\nOn a lightly floured surface, roll Homemade Oil-Free Pizza Dough into a circle or oval slightly larger than the dish. Cut several slits in dough; place on filling and seal. Brush with milk. Bake 15 minutes or until crust is browned and filling is bubbly.",
            category: "Main",
            datePublished: "2019-11-05",
            url: "https://www.forksoverknives.com/recipes/vegan-baked-stuffed/vegetable-pot-pie/"
        ),
        Recipe(
            name: "Red Lentil Loaf with Smoky Tomato Sauce Recipe",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/85949/Red-Lentil-Loaf-360x270-c.jpg",
            description: "Infinitely healthier than meat-based meatloaf and just as delicious, this savory vegan meatloaf recipe makes a welcome meal on a chilly night. Try it in next-day sandwiches, too. The smoky-sweet sauce, made with taco seasoning, smoked paprika, mustard, and Date Paste, comes together in just 10 minutes.",
            ingredients: "2 medium onions, chopped (2 cups)\n1 cup red lentils, rinsed and drained\n2 fresh poblano chile peppers, seeded and chopped (1 cup)\n3 cloves garlic, minced\n1½ teaspoons chopped fresh Mexican oregano\n2 cups cooked short grain brown rice\n¼ cup cornmeal\n¼ cup finely chopped fresh cilantro\n2 tablespoons lime juice\n1 teaspoon sea salt\n1 14.5-oz. can fire-roasted tomatoes, undrained\n¼ cup Date Paste\n1 tablespoon smoked paprika\n1 teaspoon taco seasoning\n½ teaspoon yellow mustard",
            directions: "Preheat oven to 375°F. Line a 9×5-inch loaf pan with parchment paper.\nIn a skillet combine onions, lentils, poblanos, garlic, and oregano. Stir in 1½ cups water. Bring to boiling; reduce heat. Simmer, covered, 20 minutes or until lentils are tender and water is absorbed, stirring occasionally. Stir in rice, cornmeal, cilantro, lime juice, and salt. Lightly pat mixture into the prepared loaf pan; flatten top.\nFor sauce, in a blender combine tomatoes, date paste, paprika, taco seasoning, mustard, and ½ cup water. Cover and blend until smooth. Transfer to a saucepan. Bring to boiling; reduce heat. Simmer, uncovered, 10 minutes or until slightly thick.\nSpoon ¾ cup of the sauce over loaf. Bake 30 to 40 minutes or until sauce looks dark and dry. Cool on a wire rack 15 minutes. Slice loaf and serve with the remaining sauce.",
            category: "Main",
            datePublished: "2019-03-19",
            url: "https://www.forksoverknives.com/recipes/vegan-baked-stuffed/red-lentil-loaf-recipe-smoky-tomato-sauce/"
        ),
        Recipe(
            name: "Roasted Root Vegetable Medley",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/158614/Roasted-Root-Vegetable-Medley-wordpress-360x270-c.jpg",
            description: "This simple side dish celebrates root vegetables in all their colorful, flavorful glory. The key to evenly roasting firmer veggies, such as carrots and potatoes, without adding fat is to steam them first before mixing them with the soft vegetables. Serve this vibrant recipe at your Thanksgiving feast, or enjoy it as a side with a warm bowl of soup.",
            ingredients: "4 assorted-color carrots, peeled and cut into 3-inch pieces\n6 fingerling potatoes, halved if large\n2 small parsnips, peeled, halved crosswise, and quartered lengthwise\n1 turnip, peeled and cut into sixths\n1 rutabaga, peeled and cut into thick wedges\n1 medium beet, peeled and cut into 1-inch wedges\n3 tablespoons balsamic vinegar\n2 tablespoons lemon juice\n2 tablespoons pure maple syrup\n2 tablespoons arrowroot powder\n1 teaspoon dried rosemary\n10 cloves garlic, minced\n1 fennel bulb, fronds reserved for garnish and bulb cut into 1-inch-thick wedges\n1 cup pearl onions or 2 small yellow onions cut into 1-inch-thick wedges\n1 small head celeriac, peeled and cut into large wedges\n6 large white or cremini mushrooms, quartered\n¼ teaspoon sea salt\n¼ teaspoon freshly ground black pepper",
            directions: "Preheat oven to 375°F. Working in batches if necessary, place the first six ingredients (through beet) in a steamer basket in a large saucepan. Add water to saucepan to just below basket. Bring to boiling. Steam, covered, 5 to 7 minutes or until vegetables are just tender.\nIn a large bowl whisk together the next six ingredients (through garlic). Add steamed vegetables, fennel, onions, celeriac, and mushrooms. Toss to coat.\nIn a large rimmed baking sheet spread vegetables in a single layer. Roast 15 minutes. Remove from oven and carefully stir. Roast 10 to 15 minutes more or until vegetables are tender and lightly browned.\nSeason with salt and pepper. Sprinkle with chopped reserved fennel fronds. Serve warm.",
            category: "Side",
            datePublished: "2021-10-05",
            url: "https://www.forksoverknives.com/recipes/vegan-salads-sides/roasted-root-vegetable-medley/"
        ),
        Recipe(
            name: "Raspberry Truffle Brownies",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/22720/Raspberry-Brownies-300kb-360x270-c.jpg",
            description: "These dense, fudgy, vegan brownies have loads of melt-in-your-mouth raspberry yumminess. Frozen berries actually will work better here because the dough is very stiff, and frozen berries are easier to fold in.",
            ingredients: "4 ounces unsweetened chocolate, chopped\n½ cup raspberry jam\n½ cup evaporated cane juice or cane sugar\n½ cup unsweetened applesauce\n2 teaspoons pure vanilla extract\n½ teaspoon almond extract\n1½ cups whole wheat pastry flour\n¼ cup unsweetened cocoa powder\n¼ teaspoon baking powder\n½ teaspoon baking soda\n¼ teaspoon salt\n1 cup raspberries, frozen or fresh",
            directions: "Preheat the oven to 350ºF. Line an 8 x 8-inch pan with a 10-inch square of parchment paper or have ready an 8 x 8-inch nonstick or silicone baking pan.\nMelt the chocolate in either a double boiler or the microwave. Set aside.\nIn a large mixing bowl, vigorously mix together the jam, sweetener, and applesauce. Stir in the vanilla, almond extract, and the melted chocolate.\nSift in the flour, cocoa powder, baking powder, baking soda, and salt. Mix very well until a stiff dough forms. Fold in the raspberries\nSpread the mixture into the prepared pan. It will be very thick; you’ll need to use your hands to even the batter out in the pan.\nBake the brownies for 16 to 18 minutes. Remove them from the oven and let cool completely. These taste especially good and fudgy after being refrigerated for a few hours.\n\nNote: The brownies are still very gooey after the baking time is complete, but don’t worry—that’s what you want with brownies! Gooey out of the oven means that they will be nice and fudgy when they cool. Allow them to cool completely and chill in the fridge for a few hours for best results.",
            category: "Dessert",
            datePublished: "2014-02-10",
            url: "https://www.forksoverknives.com/recipes/vegan-desserts/raspberry-truffle-brownies/"
        )
    ]
}
