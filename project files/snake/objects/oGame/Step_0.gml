#region input

if (keyboard_check(vk_control))
{
	if (keyboard_check_pressed(ord("F"))) window_set_fullscreen(!window_get_fullscreen());
	if (keyboard_check_pressed(ord("G"))) game_restart();
	if (keyboard_check_pressed(ord("P"))) room_speed = 62 - room_speed;
	if (keyboard_check_pressed(ord("D"))) oGui.debug = !oGui.debug;
}
if (keyboard_check_pressed(ord("R"))) room = r0;

if (keyboard_check_pressed(vk_escape))
{
	switch (room)
	{
		default: room = rMenu; break;
		case rMenu: if (oGui.menu_page != 0) oGui.alarm[3] = 1; break;
	}
}

#endregion

frame_length = global.difficulty;

if (room == r0)
{
	#region frame timer
	
	timer ++;

	var old_frame = frame;
	frame = timer div (60 * frame_length);
	var frame_change = (old_frame != frame);

	#endregion
	
	#region apple creation
	
	if (!instance_exists(oApple))
	{
		var appleX = -1;
		var appleY = -1;
		do
		{
			appleX = irandom_range(global.canvas_startX / cell_size, global.canvas_endX / cell_size - 1) * cell_size;
			appleY = irandom_range(global.canvas_startY / cell_size, global.canvas_endY / cell_size - 1)  * cell_size;
		}
		until (!place_meeting(appleX, appleY, oNode));
		
		instance_create_layer(appleX, appleY, "Apple", oApple);
	}
	
	#endregion
	
	#region input
	
	// keyboard controls
	var key_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
	var key_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
	var key_right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
	var key_left = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));

	// movement
	if (key_up) && (last_move != -1) && (last_move != -3) ds_queue_enqueue(move_list, -3);
	if (key_down) && (last_move != -3) && (last_move != -1) ds_queue_enqueue(move_list, -1);
	if (key_right) && (last_move != 1) && (last_move != 3) ds_queue_enqueue(move_list, 3);
	if (key_left) && (last_move != 3) && (last_move != 1) ds_queue_enqueue(move_list, 1);
	
	#endregion

	#region on frame change
	
	if (frame_change)
	{
		#region moving
		
		if (!ds_queue_empty(move_list)) last_move = ds_queue_dequeue(move_list);
		
		var newX = head.x;
		var newY = head.y;
		
		if (last_move > 0) newX += (last_move - 2) * cell_size;
		else if (last_move < 0) newY += (last_move + 2) * cell_size;
		
		//staying on screen
		if (newX < global.canvas_startX) newX = global.canvas_endX - cell_size;
		if (newX > global.canvas_endX - cell_size) newX = global.canvas_startX;
		if (newY < global.canvas_startY) newY = global.canvas_endY - cell_size;
		if (newY > global.canvas_endY - cell_size) newY = global.canvas_startY;
		
		#endregion
		
		//death
		if (place_meeting(newX, newY, oNode)) room_goto_next();
		
		// eating apples
		if (place_meeting(newX, newY, oApple))
		{
			instance_destroy(oApple);
			global.game_score += 10;
		}
		// destroy the tail node
		else
		{
			var temp = tail.next;
			instance_destroy(tail);
			tail = temp;
			tail.prev = noone;
		}
		
		// add a head node
		var inst = instance_create_layer(newX, newY, "Player", oNode);
		inst.prev = head;
		head.next = inst;
		head = inst;
	}
	
	#endregion
}