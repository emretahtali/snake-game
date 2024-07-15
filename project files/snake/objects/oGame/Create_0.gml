randomise();
room_goto_next();

global.difficulty = 0.1;
global.game_score = 0;

timer = 0;
frame = 0;
frame_length = global.difficulty;

canvas_width = 480;
canvas_height = 480;
cell_size = 32;

global.canvas_startX = ((room_width - canvas_width) / 2) div cell_size * cell_size;
global.canvas_endX = (room_width - ((room_width - canvas_width) / 2)) div cell_size * cell_size;
global.canvas_startY = ((room_height - canvas_height) / 2) div cell_size * cell_size;
global.canvas_endY = (room_height - (room_height - canvas_height) / 2) div cell_size * cell_size;

// game
head = noone;
tail = noone;

move_list = ds_queue_create();
last_move = 3;