// DOM Elements
const taskForm = document.getElementById('task-form');
const tasksList = document.getElementById('tasks-list');
const taskTitle = document.getElementById('task-title');
const taskDate = document.getElementById('task-date');
const taskPriority = document.getElementById('task-priority');
const taskColor = document.getElementById('task-color');
const colorOptions = document.querySelectorAll('.color-option');
const sortSelect = document.getElementById('sort-select');

// Set default due date to today
taskDate.valueAsDate = new Date();

// Initialize tasks array from localStorage or empty array
let tasks = JSON.parse(localStorage.getItem('tasks')) || [];

// Color picker functionality
colorOptions.forEach(option => {
    option.addEventListener('click', () => {
        // Remove selected class from all options
        colorOptions.forEach(opt => opt.classList.remove('selected'));
        // Add selected class to clicked option
        option.classList.add('selected');
        // Update hidden input value
        taskColor.value = option.dataset.color;
    });
    
    // Set initial selected color
    if (option.dataset.color === taskColor.value) {
        option.classList.add('selected');
    }
});

// Form submission
taskForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    // Create new task object
    const newTask = {
        id: Date.now().toString(),
        title: taskTitle.value,
        dueDate: taskDate.value,
        priority: taskPriority.value,
        color: taskColor.value,
        completed: false,
        createdAt: new Date().toISOString()
    };
    
    // Add task to array
    tasks.push(newTask);
    
    // Save to localStorage
    saveTasks();
    
    // Reset form
    taskForm.reset();
    taskDate.valueAsDate = new Date();
    
    // Initial color selection
    colorOptions.forEach(opt => opt.classList.remove('selected'));
    document.querySelector('.color-option.blue').classList.add('selected');
    taskColor.value = 'blue';
    
    // Re-render tasks
    renderTasks();
});

// Save tasks to localStorage
function saveTasks() {
    localStorage.setItem('tasks', JSON.stringify(tasks));
}

// Delete task
function deleteTask(taskId) {
    tasks = tasks.filter(task => task.id !== taskId);
    saveTasks();
    renderTasks();
}

// Toggle task completion
function toggleComplete(taskId) {
    tasks = tasks.map(task => {
        if (task.id === taskId) {
            return { ...task, completed: !task.completed };
        }
        return task;
    });
    saveTasks();
    renderTasks();
}

// Sort tasks
function sortTasks(tasksToSort) {
    const sortBy = sortSelect.value;
    
    return [...tasksToSort].sort((a, b) => {
        switch (sortBy) {
            case 'dueDate':
                return new Date(a.dueDate) - new Date(b.dueDate);
            case 'priority':
                const priorityValues = { high: 0, medium: 1, low: 2 };
                return priorityValues[a.priority] - priorityValues[b.priority];
            case 'color':
                return a.color.localeCompare(b.color);
            case 'title':
                return a.title.localeCompare(b.title);
            default:
                return 0;
        }
    });
}

// Format date for display
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    return new Date(dateString).toLocaleDateString(undefined, options);
}

// Render tasks to the DOM
function renderTasks() {
    // Clear current list
    tasksList.innerHTML = '';
    
    // Get sorted tasks
    const sortedTasks = sortTasks(tasks);
    
    // Check if there are no tasks
    if (sortedTasks.length === 0) {
        tasksList.innerHTML = '<li class="no-tasks">No tasks yet. Add a task above!</li>';
        return;
    }
    
    // Create task elements
    sortedTasks.forEach(task => {
        const taskItem = document.createElement('li');
        taskItem.className = `task-item ${task.completed ? 'completed' : ''}`;
        
        taskItem.innerHTML = `
            <div class="task-color" style="background-color: ${task.color}"></div>
            <div class="task-content">
                <div class="task-title">${task.title}</div>
                <div class="task-details">
                    <span class="task-date">Due: ${formatDate(task.dueDate)}</span>
                    <span class="priority-indicator priority-${task.priority}">
                        ${task.priority.charAt(0).toUpperCase() + task.priority.slice(1)}
                    </span>
                </div>
            </div>
            <div class="task-actions">
                <button class="complete-btn">${task.completed ? 'Undo' : 'Complete'}</button>
                <button class="delete-btn">Delete</button>
            </div>
        `;
        
        // Add event listeners to buttons
        const completeBtn = taskItem.querySelector('.complete-btn');
        completeBtn.addEventListener('click', () => toggleComplete(task.id));
        
        const deleteBtn = taskItem.querySelector('.delete-btn');
        deleteBtn.addEventListener('click', () => deleteTask(task.id));
        
        tasksList.appendChild(taskItem);
    });
}

// Listen for sort changes
sortSelect.addEventListener('change', renderTasks);

// Initial render
renderTasks();