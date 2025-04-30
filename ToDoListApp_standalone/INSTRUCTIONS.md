# To-Do List App Instructions

This is a simple to-do list application with:
1. Color coding
2. Due dates
3. Priority sorting

## How to Use

### Open the App
1. Double-click the `index.html` file to open in your browser
2. That's it - no installation needed!

### Using the App
1. **Add Tasks**:
   - Enter a task title
   - Set a due date
   - Choose a priority level
   - Select a color
   - Click "Add Task"

2. **Manage Tasks**:
   - **Sort**: Use the dropdown at the top to sort by due date, priority, color, or title
   - **Complete**: Click the "Complete" button to mark tasks as done
   - **Delete**: Click the "Delete" button to remove tasks

3. **Your Data**:
   - All tasks are automatically saved in your browser
   - They will persist between sessions on the same device

## Native App Version

To convert this to a true native app:

1. Install Node.js from https://nodejs.org/
2. Open Terminal and navigate to this folder
3. Run these commands:
   ```
   npm init -y
   npm install electron electron-packager --save-dev
   ```
4. Create a file named `main.js` with the content from the included `main.js.txt` file
5. Edit the `package.json` file to include:
   ```json
   {
     "name": "ToDoApp",
     "main": "main.js",
     "scripts": {
       "start": "electron .",
       "package": "electron-packager . ToDoApp --platform=darwin --arch=x64 --out=dist"
     }
   }
   ```
6. Run `npm start` to launch the app
7. Run `npm run package` to create a standalone app