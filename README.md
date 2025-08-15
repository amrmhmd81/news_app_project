# News App

A Flutter news application that gets and displays news articles from newsapi. The app shows a list of news articles with search feature and detailed article views.

## Project Description

This is a news reading app built with Flutter. Users can:
- View a list of latest news articles
- Search for specific articles
- Read article details
- Open full articles in external browser

The app uses newsapi to get real-time news data and displays it in a clean interface.

## Folder Structure Explanation

The app is organized into three main folders:

**lib/domain/** - Business logic
- entities/ - Data models like NewsArticle
- repositories/ - Data access interfaces  
- usecases/ - Business operations

**lib/data/** - Data handling
- datasources/ - API calls and data sources
- models/ - Data transfer objects
- repoImpl/ - Repository implementations

**lib/presentation/** - User interface
- bloc/ - State management
- pages/ - App screens
- widgets/ - Reusable UI components

## How SOLID and Clean Architecture were applied

### SOLID Principles

**1. Single Responsibility** - Each class does one thing only:
- NewsArticle class only holds news data
- NewsBloc class only manages app state
- NewsCardWidget only shows news items

**2. Open/Closed** - Easy to add new features without changing old code:
- Can add new data sources without changing business logic
- Can add new screens without affecting data layer

**3. Liskov Substitution** - Can swap different implementations:
- NewsRepositoryImpl can replace NewsRepository
- NewsDataSourceImpl can replace NewsDataSource

**4. Interface Segregation** - Small, focused interfaces:
- NewsRepository only has news methods
- Each BLoC event does one specific thing

**5. Dependency Inversion** - High-level code doesn't depend on low-level code:
- Business logic doesn't depend on API implementation
- Use cases depend on interfaces, not concrete classes

### Clean Architecture

The app is divided into three layers:

1. **Domain Layer** (Core Business Logic)
   - Contains business rules and entities
   - Doesn't depend on other layers
   - Pure business logic

2. **Data Layer** (Infrastructure)
   - Handles data from external sources (API)
   - Implements repository interfaces
   - Converts data between formats

3. **Presentation Layer** (UI)
   - Shows data to users
   - Handles user interactions
   - Manages app state