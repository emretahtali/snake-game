if (room == r0)
{
	draw_set_halign(fa_center);
	draw_set_color(c_white);

	//vertical lines
	draw_line_width(global.canvas_startX - 10, global.canvas_startY - 10, global.canvas_startX - 10, global.canvas_endY + 8, 10);
	draw_line_width(global.canvas_endX + 8, global.canvas_startY - 10, global.canvas_endX + 8, global.canvas_endY + 8, 10);
	
	//horizontal lines
	draw_line_width(global.canvas_startX - 15, global.canvas_startY - 10, global.canvas_endX + 13, global.canvas_startY - 10, 10);
	draw_line_width(global.canvas_startX - 15, global.canvas_endY + 8, global.canvas_endX + 13, global.canvas_endY + 8, 10);
	
	//score
	draw_set_color(make_color_rgb(255, 0, 64));
	draw_set_font(fBitCell);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text_transformed(room_width / 2, global.canvas_startY / 2, "score: " + string(global.game_score), 3, 3, 0);
	
	if (debug)
	{
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
	}
}

else if (room == rgameover)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fBitCell);

	if (credits)
	{
		draw_set_color(c_white);
		draw_text_transformed(room_width / 2, room_height / 16 * 4, "game over!", 15, 15, 5);

		draw_set_color(make_color_rgb(255, 0, 64));
		draw_text_transformed(room_width / 2, room_height / 16 * 6.5, "score: " + string(global.game_score), 6, 6, 5);

		draw_set_color(c_white);
		if (i) draw_text_transformed(room_width / 2, room_height / 16 * 12, "press r to restart", 3, 3, 5);
	}
}

else if (room == rMenu)
{
	if ((keyboard_check_pressed(vk_up)) || (keyboard_check_pressed(ord("W")))) menu_cursor --;
	if ((keyboard_check_pressed(vk_down)) || (keyboard_check_pressed(ord("S")))) menu_cursor ++;
		
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fBitCell);
	
	if (menu_timer > 0)
	{
		draw_set_color(c_white);
		draw_text_transformed(room_width / 2, room_height / 16 * 2.5, "snake", 20, 20, 5);
	}
	
	switch (menu_page)
	{
		case 0:
		{
			if (menu_cursor < 0) menu_cursor = 2;
			if (menu_cursor > 2) menu_cursor = 0;
			
			if (menu_timer > 1)
			{
				if (menu_cursor == 0) draw_set_color(make_color_rgb(26, 247, 237));
				else draw_set_color(make_color_rgb(255, 0, 64));
				
				draw_text_transformed(room_width / 2, room_height / 16 * 6, "play", 6, 6, 5);
			}
	
			if (menu_timer > 2)
			{
				if (menu_cursor == 1) draw_set_color(make_color_rgb(26, 247, 237));
				else draw_set_color(make_color_rgb(255, 0, 64));
				
				draw_text_transformed(room_width / 2, room_height / 16 * 8, "difficulty", 6, 6, 5);
			}
			
			if (menu_timer > 3)
			{
				if (menu_cursor == 2) draw_set_color(make_color_rgb(26, 247, 237));
				else draw_set_color(make_color_rgb(255, 0, 64));
				
				draw_text_transformed(room_width / 2, room_height / 16 * 10, "quit", 6, 6, 5);
			}	
			
			if (keyboard_check_pressed(vk_space)) || (keyboard_check_pressed(vk_enter))
			{
				switch (menu_cursor)
				{
					case 0: alarm[4] = 1; break;
					case 1: alarm[3] = 1; break;
					case 2: game_end(); break;
				}
			}
			
			break;
		}
		
		case 1:
		{
			if (menu_cursor < 0) menu_cursor = 3;
			if (menu_cursor > 3) menu_cursor = 0;
			
			if (menu_timer > 1)
			{
				if (menu_cursor == 0) draw_set_color(make_color_rgb(26, 247, 237));
				else draw_set_color(make_color_rgb(255, 0, 64));
				
				draw_text_transformed(room_width / 2, room_height / 16 * 6, "easy", 6, 6, 5);
			}
	
			if (menu_timer > 2)
			{
				if (menu_cursor == 1) draw_set_color(make_color_rgb(26, 247, 237));
				else draw_set_color(make_color_rgb(255, 0, 64));
				
				draw_text_transformed(room_width / 2, room_height / 16 * 8, "normal", 6, 6, 5);
			}
	
			if (menu_timer > 3)
			{
				if (menu_cursor == 2) draw_set_color(make_color_rgb(26, 247, 237));
				else draw_set_color(make_color_rgb(255, 0, 64));
				
				draw_text_transformed(room_width / 2, room_height / 16 * 10, "fun", 6, 6, 5);
			}
	
			if (menu_timer > 4)
			{
				if (menu_cursor == 3) draw_set_color(make_color_rgb(26, 247, 237));
				else draw_set_color(make_color_rgb(255, 0, 64));
				
				draw_text_transformed(room_width / 2, room_height / 16 * 12, "hard", 6, 6, 5);
			}
				
			if (keyboard_check_pressed(vk_space)) || (keyboard_check_pressed(vk_enter))
			{
				switch (menu_cursor)
				{
					case 0: global.difficulty = 0.3; break;
					case 1: global.difficulty = 0.18; break;
					case 2: global.difficulty = 0.1; break;
					case 3: global.difficulty = 0.05; break;
				}
				alarm[3] = 1;
			}
			
			break;
		}
	}
}