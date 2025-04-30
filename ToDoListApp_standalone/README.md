# To-Do List Native Desktop App

A desktop to-do list application with color coding, due dates, and priority sorting.

## Features

1. **Color Coding**: Assign different colors to tasks for visual organization
2. **Due Dates**: Set and track task deadlines
3. **Priority Sorting**: Organize tasks by low, medium, or high priority
4. **Task Management**: Create, edit, delete, and mark tasks as complete
5. **Persistent Storage**: Tasks are saved automatically between sessions
6. **Sorting Options**: Sort by due date, priority, color, or title

## Getting Started

### Prerequisites

- Node.js and npm

### Installation

1. Install dependencies:
   ```
   npm install
   ```

2. Run the app:
   ```
   npm start
   ```

### Building Native App

To create a standalone application:

```
npm run package
```

This will create a native macOS application in the `dist` folder.

## Usage

1. **Add Tasks**: Fill out the form at the top and click "Add Task"
2. **Sort Tasks**: Use the dropdown to sort by different criteria
3. **Complete Tasks**: Click the "Complete" button to mark a task as done
4. **Delete Tasks**: Click the "Delete" button to remove a task