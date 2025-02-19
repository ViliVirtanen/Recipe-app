# Recipe Manager

## Application Description
Recipe Manager is a device-agnostic Flutter application developed for the Device Agnostic Design university course. The application serves as a personal recipe management system, allowing users to organize, store, and manage their cooking recipes efficiently across different devices and screen sizes.

### Key Features
- Create and edit recipes
- Categorize recipes for better organization
- Search functionality to quickly find recipes
- Responsive design that works on mobile, tablet, and desktop
- Statistical insights about your recipe collection

## Deployed Application
The application is deployed and accessible at: https://recipeappdad.web.app

## Usage Instructions

### Managing Recipes
1. **Adding a Recipe**
   - Click the "+" button in the navigation bar
   - Fill in the recipe details:
     - Title (required)
     - Category (optional)
     - Description
     - Ingredients (one per line)
     - Steps (one per line)
   - Click "Save" to store the recipe

2. **Viewing Recipes**
   - All recipes are displayed on the home screen
   - Click any recipe to view its full details
   - On larger screens, recipes are displayed in a grid
   - On mobile devices, recipes are shown in a list

3. **Searching Recipes**
   - Use the search bar at the top of the home screen
   - Search works across titles, categories, descriptions, and ingredients
   - Results update in real-time as you type

4. **Editing and Deleting**
   - Open a recipe and click "Edit" to modify its details
   - Use the delete button (trash icon) to remove a recipe
   - Confirmation is required before deletion

5. **Statistics**
   - Access the Statistics screen from the navigation bar
   - View insights about your recipe collection:
     - Total number of recipes
     - Average ingredients per recipe
     - Average steps per recipe
     - Category distribution
     - Most/least ingredients in a recipe

### Responsive Design Features
- Adapts to different screen sizes automatically
- Tablet/Desktop view (>600px):
  - Grid layout for recipes
  - Side-by-side layout for recipe details
  - Enhanced spacing and typography
- Mobile view (<600px):
  - List layout for recipes
  - Stacked layout for recipe details
  - Optimized for touch interaction

## Technical Implementation
- Built with Flutter for cross-platform compatibility
- Uses GetX for state management and navigation
- Implements responsive design principles
- Local storage using Hive for offline functionality
- Firebase hosting for web deployment

## Development Setup
1. Clone the repository
2. Ensure Flutter SDK is installed (^3.6.1)
3. Run `flutter pub get` to install dependencies
4. Use `flutter run` to start the application locally

## Project Structure
```
lib/
├── controllers/     # State management
├── pages/          # Screen implementations
├── widgets/        # Reusable UI components
└── main.dart       # Application entry point
```
