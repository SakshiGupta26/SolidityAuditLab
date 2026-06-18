// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] private todos;

    event TodoCreated(uint256 indexed id, string text);
    event TodoUpdated(uint256 indexed id, string text);
    event TodoCompleted(uint256 indexed id, bool completed);
    event TodoDeleted(uint256 indexed id);

    /// Create a new todo
    function createTodo(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));

        emit TodoCreated(todos.length - 1, _text);
    }

    /// Get a todo by index
    function getTodo(uint256 _id)
        external
        view
        returns (string memory text, bool completed)
    {
        require(_id < todos.length, "Invalid todo ID");

        Todo storage todo = todos[_id];
        return (todo.text, todo.completed);
    }

    /// Get total number of todos
    function getTodoCount() external view returns (uint256) {
        return todos.length;
    }

    /// Update todo text
    function updateTodo(uint256 _id, string calldata _text) external {
        require(_id < todos.length, "Invalid todo ID");

        todos[_id].text = _text;

        emit TodoUpdated(_id, _text);
    }

    /// Toggle completed status
    function toggleCompleted(uint256 _id) external {
        require(_id < todos.length, "Invalid todo ID");

        todos[_id].completed = !todos[_id].completed;

        emit TodoCompleted(_id, todos[_id].completed);
    }

    /// Delete a todo (keeps array compact)
    function deleteTodo(uint256 _id) external {
        require(_id < todos.length, "Invalid todo ID");

        todos[_id] = todos[todos.length - 1];
        todos.pop();

        emit TodoDeleted(_id);
    }
}
