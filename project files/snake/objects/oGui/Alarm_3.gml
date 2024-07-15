 if (menu_timer > 1)
 {
	alarm[3] = 3;
	menu_timer --;
	menu_lock = false;
}
else
{
	menu_page = 1 - menu_page;
	menu_cursor = 0;
	alarm[2] = 30;
	menu_lock = true;
}