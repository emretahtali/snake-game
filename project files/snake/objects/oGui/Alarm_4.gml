 menu_lock = false;
 
 if (menu_timer > 0)
 {
	alarm[4] = 5;
	menu_timer --;
}
else if (menu_timer == 0)
{
	alarm[4] = 30;
	menu_timer --;
}
else
{
	room = r0;
	menu_cursor = 0;
	menu_lock = true;
}