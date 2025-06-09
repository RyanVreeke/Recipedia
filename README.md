# Recipedia

<img src=Assets/RecipediaLightIcon.png height="250" width="250"> <img src=Assets/RecipediaDarkIcon.png height="250" width="250">

**Recipe Encyclopedia / Wikipedia iOS app for cooking instructions and video walkthroughs.**

Explore the luxurious recipes of the world and take your taste buds to new heights!

> [!NOTE] 
> _Fetch iOS Mobile Take Home Project._

## Summary: Include screen shots or a video of your app highlighting its features

**Recipedia** is your go-to destination for discovering and experimenting with a wide variety of recipes right from home. I built a robust and intuitive interface that allows users to easily browse and navigate through recipes. You can quickly scroll through different options, tap on a recipe to view its details, or search by recipe name or cuisine. Filtering by cuisine is also supported for faster access.

Customization features include the ability to toggle between system, light, and dark appearance modes, as well as switch between single-column and multi-column layouts for recipe viewing.

> [!NOTE] 
> _Supports iOS 16.0+._

### Screenshots:

#### Main app functionality:

| Recipes View | Recipe View | Pull to Refresh | Empty Data | Malformed Data | 
| :---: | :---: | :---: | :---: | :---: |
| <img src=Assets/RecipesView.png width="250"> | <img src=Assets/RecipeView.png width="250"> | <img src=Assets/PulltoRefresh.png width="250"> | <img src=Assets/EmptyData.png width="250"> | <img src=Assets/MalformedData.png width="250"> |

- **Recipes View:** Allows you to view all of the recipes retrived from the network.
- **Recipe View:** Allows you to view the information of the selected recipe and link out to its instructions and video walkthrough.

#### Added functionality and design:

| Search | Filter | Single Column | Appearance |
| :---: | :---: | :---: | :---: |
| <img src=Assets/Search.png width="250"> | <img src=Assets/Filter.png width="250"> | <img src=Assets/SingleColumn.png width="250"> | <img src=Assets/Appearance.png width="250"> |

- **Search:** Allows you to search on name and cuisine of recipes.
- **Filter:** Allows you to quickly filter on the cuisine of a recipe (can be paired with searching by recipe name).
- **Single Column:** Allows you to view recipes in a single column making it easier to read and view recipe information.
- **Appearance:** Allows you to select the appearance mode for your app (system, light, dark). I really enjoy the appearance of apps, in particular dark mode, and so I wanted to give that same ability here.

#### Video demo:

You can download the video demo located at [Assets/RecipediaDemo.mp4](Assets/RecipediaDemo.mp4).

## Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

When developing **Recipedia**, I focused on building a service to fetch recipes from the network without external dependencies, implementing efficient caching and loading of images from disk, and writing unit tests for the application. Each of these focus areas helps ensure the app runs smoothly and is less error prone. Here are the steps I took to develop Recipedia:

### Documentation and project structure setup:

I created the iOS app and the GitHub repository, added basic documentation, and a PR template to guide the code development process. Next, I created a basic app architecture structure.

**Architecture:**

    Recipedia/
    ├── RecipediaApp.swift
    ├── PresentationLayer/
    ├── DomainLayer/
    ├── DataLayer/

This structure implements a clean architecture style, setting up the `DataLayer`, `DomainLayer`, `PresentationLayer`, and the entry file `RecipediaApp.swift`.  
- The **DataLayer** contains services and data storage for the app.  
- The **DomainLayer** houses the models representing different objects used throughout the app.  
- The **PresentationLayer** contains UI views and components.  

In a real implementation, the `DataLayer` and `PresentationLayer` depend on the `DomainLayer` and do not directly access each other. This ensures a good separation of concerns and helps manage files and data flow effectively. `RecipediaApp.swift` runs the root view of the application.

### `RecipeService` implementation:

My first focus area was implementing the Recipe Service to fetch recipe data from the given endpoints. I created a service protocol defining the `getRecipes` function, along with the service itself. I used Swift's async/await to follow the Swift Concurrency requirement.

To simplify endpoint construction, I built an `Endpoint` utility that allows flexible creation of requests using a base URL, path, method, and headers. I also implemented error handling for cases such as invalid URLs, bad server responses, and general errors such as a network failures.

I wanted to look at the service before the UI because this allowed me to confirm data decoding, identify optional fields, and better understand how the data structure would fit into the app's UI/UX.

**_Requirements: Swift Concurrency, No External Dependencies_**

### First implementation of `RecipesView` and displaying the data:

Next, I created a simple layout to display the data received from the service. I focused on showing basic recipe information such as the name, cuisine type, and photo to validate correct data retrieval and display. I also implemented pull to refresh as this was a requirement for a user to be able to refresh the data at any time.

To meet the SwiftUI and minimum recipe information requirements, I used a `RecipeCard` component to encapsulate and display each `Recipe` model. These cards were arranged in a grid layout within `RecipesView` for better visual presentation.

**_Requirements: SwiftUI, Minimum Recipe Information_**

### Image Caching and Loading:

After setting up the basic UI, I focused on image caching and loading from disk to support efficient network usage and improve responsiveness. When deciding the route I would go to implement the caching and loading of images I thought to using CoreData, but upon some research it seemed utilizing FileManager was perhaps a simpler but also preferred option when it came to storing images on disk.

I created a `Cache` actor to ensure thread safe disk reads/writes using a single context. This cache is agnostic to the type of data stored, you just specify a `folderName` if desired to set the storage directory name. It supports basic operations: `get`, `set`, `delete`, and `clear`.

To display images in the UI, I built an `ImageLoader` class which utilizes a Cache. It attempts to load images from the cache first and falls back to downloading them if unavailable from the network and saving them to disk upon success.

With these utilities, I was able to load images efficiently in the `RecipeCard` component and `RecipeView`.

**_Requirements: Efficient Network Usage, Swift Concurrency, No External Dependencies_**

### Recipe View and Links:

Next, I implemented a single `RecipeView` that allows users to view full recipe details when tapping on a `RecipeCard`. This view also includes links if available to the recipe instructions and a video walkthrough, helping fulfill the minimum information requirements.

**_Requirements: SwiftUI, Minimum Recipe Information_**

### Unit Tests:

After adding the `RecipeView`, I turned my attention to the final major focus area of testing. I focused on writing meaningful unit tests for the `RecipeService`, `Cache`, and `ImageLoader`.

I believe testing is essential for long-term maintenance, ensuring code quality, and helping to prevent breaking changes. With that I also used the native Swift Testing library, which offers a streamlined experience for writing tests. It allows you to write clear tests and it feels familair to writing regular classes in Swift.

To test the `RecipeService`, I mocked `URLSession` to simulate different responses and network scenarios. For the `Cache`, I wrote tests for individual operations using real disk writes. For the `ImageLoader`, I created an in-memory `CacheMock` and used a mocked `URLSession`.

By identifying dependencies and isolating units, I was able to create reliable mocks and cover edge cases effectively. This allowed for the creation of meaningful unit tests.

**_Requirements: Testing_**

### Final refining of UI, app functionality, and extra features:

With the core features and focus areas implemented, I polished the UI, improved app functionality, and added extra enhancements to elevate the user experience.

These changes include:
- View States: Empty, Error, etc...
- Searching and filtering of Recipes
- App appearance and column changing features
- Extra large image loading functionality

**_Requirements: SwiftUI, Minimum Recipe Information_**

**Overall, I was able to create a sleek functional app that met all of the project criteria.**

- [x] Swift Concurrency
- [x] No External Dependencies
- [x] Efficient Network Usage
- [x] Testing
- [x] SwiftUI
- [x] Refresh the list of recipes at any time
- [x] Empty list empty state to inform users
- [x] Malformed data handled gracefully

## Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

With various stop and start times throughout a busy week I worked approximately 8 hours and 45 minutes on this project. Below is the breakdown of how I allocated my time.

### DataLayer time:
- RecipeService: ~0 hr 45 min
- Cache: ~1 hr 00 min
- ImageLoader: ~0 hr 45 min
- Total: ~2 hr 30 min

### PresentationLayer time:
- RecipesView: ~1 hr 0 min
- RecipeView: ~0 hr 30 min
- Pull to refresh / UI logic: ~0 hr 30 min
- Searching, filtering: ~0 hr 30 min
- Total: ~2 hr 30 min

### Unit Testing time:
- RecipeServiceTests: ~0 hr 45 min
- CacheTests: ~0 hr 30 min
- ImageLoaderTests: ~0 hr 30 min
- Total: ~1 hr 45 min

### Extra features time:
- Appearance: ~0 hr 15 min
- Column layout: ~0 hr 15 min
- Total: ~0 hr 30 min

### Documentation time:
- Code documentation: ~0 hr 30 min
- Project turn in documentation: ~1 hr 0 min
- Total: ~1 hr 30 min

## Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

One significant decision I made was how to implement caching. I considered caching the entire `Recipe` object returned from the network into CoreData. However, based on the project requirements which mentioned just caching images to disk I opted to cache just the images data. This approach made sense because the recipe data itself (UUIDs, strings, and URLs) was lightweight and quick to fetch from the network. My research also supported this strategy where storing image data directly to disk was a popular solution over CoreData when it came to images.

A trade-off I made during development was to prioritize building robust services and writing meaningful unit tests over refactoring UI code. While the app is fully functional and meets UI requirements, some views have especially large `body` implementations and could benefit from further cleanup. This could include:
- Extracting duplicate or repetitive code into reusable view builder functions
- Improving readability and structure for future maintenance
- Adding more documentation comments

Given the scope of the app and the technical priorities (services, caching, and testing), I felt it was reasonable to defer UI refactoring in favor of a solid and maintainable backend foundation.

## Weakest Part of the Project: What do you think is the weakest part of your project?

The weakest part of my project is, in my opinion, the code formatting of my `View` files. Like mentioned above in the trade-off section there are several areas where I could have refactored duplicated code to make it more reusable and efficient. Additionally, some of the UI implementations are harder to read and maintain because the `body` properties of many views are quite large and unsectioned. I do see this as a weakness, as unnecessary code duplication adds no value to a codebase with more points of failure, and files spanning hundreds of lines become difficult to read and maintain unless they’re thoughtfully refactored.

With more time, I would have restructured the views to be more modular by breaking them into smaller, composable view builders. I also would have ensured that functional code wasn’t needlessly duplicated. Together, these improvements would significantly enhance readability, maintainability, and the overall developer experience when working with the UI layer.

## Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I placed a strong emphasis on the data flow and behind the scenes implementations of the application. That said, I greatly enjoy crafting visually appealing and user-friendly interfaces. There’s something incredibly satisfying about using an app that feels intuitive, looks great, and provides value. With that in mind, I hope the UI/UX, short filtering haptics, and appearance themes are enjoyable!
