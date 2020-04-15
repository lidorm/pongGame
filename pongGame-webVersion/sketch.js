var player1 = {
	x: 20,
	y: 150,
	width: 20,
	height: 100,
};
var player2 = {
	x: 560,
	y: 150,
	width: 20,
	height: 100,
};
var ball = {
	x: 300,
	y: 200,
	width: 30,
	height: 30,
};
var playerSpeed;
var ballSpeedX;
var ballSpeedY;
var screenType;
var resetButton;
var socket;

function setup() {
	var width = 600;
	var height = 400;
	createCanvas(width, height);
	playerSpeed = 4;
	ballSpeedX = 5;
	ballSpeedY = 5;
	screenType = 0;
}

function draw() {
	// Draw objects and board
	background(0, 200, 0);
	noFill();
	line(300, 0, 300, height);
	ellipse(300, 200, 90, 90);
	stroke(0);
	fill(255);
	rect(player1.x, player1.y, player1.width, player1.height);
	rect(player2.x, player2.y, player2.width, player2.height);
	ellipse(ball.x, ball.y, ball.width, ball.height);
	stroke(255);

	// Start game!
	if (screenType === 0) {
		textSize(32);
		textAlign(CENTER);
		text("Click to start the game!", width / 2, height - 100);
	}
	if (screenType === 1) {
		// Ball logic
		ball.x = ball.x + ballSpeedX;
		ball.y = ball.y + ballSpeedY;
		// Check if someone lost
		if (ball.x < 0 || ball.x > 600) {
			textSize(68);
			textAlign(CENTER);
			text("GAME OVER!", width / 2, 100);
			textSize(32);
			textAlign(CENTER);
			text('Click to play again!', (width / 2), height - 100);
		}

		if (ball.y > height - 10 || ball.y < 10) {
			ballSpeedY = ballSpeedY * -1;
		}

		// Player movement
		// Player2
		if (keyIsDown(DOWN_ARROW)) {
			if (player2.y < height - 100) {
				player2.y = player2.y + playerSpeed;
			}
		}
		// Player1
		if (keyIsDown(SHIFT)) {
			if (player1.y > 0) {
				player1.y = player1.y - playerSpeed;
			}
		}
		// Player2
		if (keyIsDown(UP_ARROW)) {
			if (player2.y > 0) {
				player2.y = player2.y - playerSpeed;
			}
		}
		// Player1
		if (keyIsDown(CONTROL)) {
			if (player1.y < height - 100) {
				player1.y = player1.y + playerSpeed;
			}
		}

		// Redirect ball when the player blocks it
		if (
			ball.y < player2.y + 100 &&
			ball.y > player2.y &&
			ball.x === player2.x - 10
		) {
			ballSpeedX = ballSpeedX * -1;
		}
		if (
			ball.y < player1.y + 100 &&
			ball.y > player1.y &&
			ball.x === player1.x + 30
		) {
			ballSpeedX = ballSpeedX * -1;
		}
	}
}

function mousePressed() {
	if (screenType === 1) {
		reset();
	}
	screenType = 1;
}

function reset() {
	// Reset all variables to defualt
	// Player1
	player1.x = 20;
	player1.y = 150;
	player1.width = 20;
	player1.height = 100;

	// Player2
	player2.x = 560;
	player2.y = 150;
	player2.width = 20;
	player2.height = 100;

	// Ball
	ball.x = 300;
	ball.y = 200;
	ball.width = 30;
	ball.height = 30;

	screenType = 0;
}