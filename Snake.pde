void setup() {
	size(900, 600);
	frameRate(30);
}

/////////////////////
// Part A

// can be "right", "left", "up", or "down"
String direction = "right";
int tileSize = 50;
int positionX = 3;
int positionY = 5;

int velocityX = 1;
int velocityY = 0;

int maxTilePosX = 900/tileSize;
int maxTilePosY = 600/tileSize;

int foodX = round(random(0, maxTilePosX - 1));
int foodY = round(random(0, maxTilePosY - 1));


int frameNum = 0;

int updateFrame = 10;	// 3 times per second

boolean alive = true;

// we use ArrayList because our snake needs to grow!
ArrayList<int[]> snake = new ArrayList<int[]>();

///////////////////
// Part B
void draw() {
	if (frameNum == 0) {
		snake.add(new int[] {positionX, positionY});
	}
	
	///////////////////
	// Part C
	// deal with keyboard input
	if (keyPressed) {
		if (keyCode == UP && direction != "down") {
			direction = "up";
		}
		if (keyCode == DOWN && direction != "up") {
			direction = "down";
		}
		if (keyCode == LEFT && direction != "right") {
			direction = "left";
		}
		if (keyCode == RIGHT && direction != "left") {
			direction = "right";
		}
	}

	///////////////////
	// Part D
	// change direction of velocity
	if (direction == "up") {
		velocityX = 0;
		velocityY = -1;
	}
	if (direction == "down") {
		velocityX = 0;
		velocityY = 1;
	}
	if (direction == "left") {
		velocityX = -1;
		velocityY = 0;
	}
	if (direction == "right") {
		velocityX = 1;
		velocityY = 0;
	}

	/////////////////////////////////////////////////////////////////////////////
	// Part E
	// update loop that runs every 10 frames
	if (frameNum % updateFrame == 0 && alive) {
		
		//////////////////////////////////
		////// Snake Movement
		if (alive) {
			// set the rest of the body segments to the next forward segment part
			for (int i = (snake.size() - 1); i >= 1; i--) {
				snake.get(i)[0] = snake.get(i - 1)[0];
				snake.get(i)[1] = snake.get(i - 1)[1];
				
			}

			// move "head" last (in the velocity's direction)
			snake.get(0)[0] += velocityX;
			snake.get(0)[1] += velocityY;

			///////////////////
			// Part F
			// allow body parts to cross walls
			for (int i = 0; i < snake.size(); i++) {
				if (snake.get(i)[0] < 0) {
					snake.get(i)[0] += maxTilePosX;
				}
				if (snake.get(i)[0] > maxTilePosX - 1) {
					snake.get(i)[0] -= maxTilePosX;
				}
				if (snake.get(i)[1] < 0) {
					snake.get(i)[1] += maxTilePosY;
				}
				if (snake.get(i)[1] > maxTilePosY - 1) {
					snake.get(i)[1] -= maxTilePosY;
				}
			}



			/////////////////////////////////////////
			// Part G
			///////// Eat
			// check if has "eaten" food
			if (snake.get(0)[0] == foodX && snake.get(0)[1] == foodY) {
				// grow the snake body at 0, 0
				snake.add(new int[] {-1, -1});
				// create new small food
				foodX = round(random(0, maxTilePosX - 1));
				foodY = round(random(0, maxTilePosY - 1));
			}

			//////////////////////////////////////
			// Part H
			// do not eat thyself!
			for (int i = 1; i < snake.size(); i++) {
				if (snake.get(0)[0] == snake.get(i)[0] && snake.get(0)[1] == snake.get(i)[1]) {
					alive = false;
					break;
				}
			}
		}


	}

	//////////////////////////////////////////////
	// Part I

	background(255, 255, 255);
	////////////////
	// draw the snake first
	fill(0, 150, 0);
	strokeWeight(10);
	stroke(255, 255, 255);
	for (int i = 0; i < snake.size(); i++) {
		rect(tileSize * snake.get(i)[0], tileSize * snake.get(i)[1], tileSize, tileSize);
	}

	// draw the food
	fill(255, 0, 0);
	rect(tileSize * foodX, tileSize * foodY, tileSize, tileSize);

	//////////////////////////////////
	// Part J
	if (!alive) {
		// you are dead
		fill(255, 255, 255, 150);
		rect(0, 0, 900, 600);
		fill(0, 0, 0);
		textSize(30);
		textAlign(CENTER);
		text("Yer DIED", 450, 250);
		text("Press Enter To Restart", 450, 300);
		if (key == ENTER) {
			// reset snake
			snake.clear();
			snake.add(new int[] {3, 5});
			direction = "right";
			foodX = round(random(0, maxTilePosX - 1));
			foodY = round(random(0, maxTilePosY - 1));
		}

		alive = true;
	}
	
	////////////////////////////////
	// Part K
	frameNum = frameNum + 1;
}