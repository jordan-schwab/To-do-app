# Building Your To-Do List Native App

I've set up a desktop app using Electron. Here's how to build and run it:

## Instructions

1. First, make sure you have Node.js installed:
   - Download from: https://nodejs.org/
   - This provides npm (Node Package Manager) that we need

2. Open Terminal and navigate to the app folder:
   ```
   cd /Users/jordanschwab/WebToDoApp
   ```

3. Install dependencies:
   ```
   npm install
   ```

4. Run the app:
   ```
   npm start
   ```

5. To create a standalone app:
   ```
   npm run package
   ```
   This will create a native macOS application in the 'dist' folder

## Alternative Option

If you don't want to set up Node.js right now, you can just open the web version:

```
open /Users/jordanschwab/WebToDoApp/index.html
```

This will open in your browser but has all the same features (color coding, due dates, and priority sorting).