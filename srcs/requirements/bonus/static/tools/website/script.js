const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');
const scoreDisplay = document.getElementById('score');
const pauseOverlay = document.getElementById('pauseOverlay');
const restartButton = document.getElementById('restartButton');

// Game constants
const gridSize = 20;
const canvasSize = 400;
canvas.width = canvasSize;
canvas.height = canvasSize;

let snake = [{ x: 100, y: 100 }];
let direction = { x: gridSize, y: 0 };
let food = { x: 200, y: 200 };
let score = 0;
let gameSpeed = 150;
let gamePaused = false;

let gameInterval;

// Draw a rectangle
function drawRect(x, y, color) {
    ctx.fillStyle = color;
    ctx.fillRect(x, y, gridSize, gridSize);
}

// Generate random food position
function generateFood() {
    food = {
        x: Math.floor(Math.random() * (canvasSize / gridSize)) * gridSize,
        y: Math.floor(Math.random() * (canvasSize / gridSize)) * gridSize,
    };
}

// Check for collisions
function checkCollision(head) {
    for (let segment of snake) {
        if (head.x === segment.x && head.y === segment.y) {
            return true;
        }
    }
    return false;
}

// Game loop
function gameLoop() {
    if (gamePaused) return;

    const head = { x: snake[0].x + direction.x, y: snake[0].y + direction.y };

    // Borderless gameplay
    if (head.x >= canvasSize) head.x = 0;
    if (head.x < 0) head.x = canvasSize - gridSize;
    if (head.y >= canvasSize) head.y = 0;
    if (head.y < 0) head.y = canvasSize - gridSize;

    if (checkCollision(head)) {
        alert(`Game Over! Your score: ${score}`);
        resetGame();
        return;
    }

    snake.unshift(head);

    if (head.x === food.x && head.y === food.y) {
        score++;
        scoreDisplay.textContent = score;
        if (gameSpeed > 50) {
            gameSpeed -= 5;
            clearInterval(gameInterval);
            gameInterval = setInterval(gameLoop, gameSpeed);
        }
        generateFood();
    } else {
        snake.pop();
    }

    ctx.clearRect(0, 0, canvasSize, canvasSize);

    drawRect(food.x, food.y, 'red');

    for (let segment of snake) {
        drawRect(segment.x, segment.y, 'lime');
    }
}

// Pause and resume the game
function togglePause() {
    gamePaused = !gamePaused;
    pauseOverlay.classList.toggle('hidden', !gamePaused);
}

// Reset game to initial state
function resetGame() {
    snake = [{ x: 100, y: 100 }];
    direction = { x: gridSize, y: 0 };
    score = 0;
    gameSpeed = 150;
    scoreDisplay.textContent = score;
    generateFood();
    clearInterval(gameInterval);
    gameInterval = setInterval(gameLoop, gameSpeed);
}

// Control the snake
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        togglePause();
        return;
    }

    if (!gamePaused) {
        switch (e.key) {
            case 'ArrowUp':
                if (direction.y === 0) direction = { x: 0, y: -gridSize };
                break;
            case 'ArrowDown':
                if (direction.y === 0) direction = { x: 0, y: gridSize };
                break;
            case 'ArrowLeft':
                if (direction.x === 0) direction = { x: -gridSize, y: 0 };
                break;
            case 'ArrowRight':
                if (direction.x === 0) direction = { x: gridSize, y: 0 };
                break;
        }
    }
});

// Restart button functionality
restartButton.addEventListener('click', () => {
    togglePause();
    resetGame();
});

// Start the game
generateFood();
gameInterval = setInterval(gameLoop, gameSpeed);
