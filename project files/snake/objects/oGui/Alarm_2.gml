 if (menu_timer < 4 + menu_page) && (menu_lock)
 {
	switch (menu_timer)
	{
		case -1: default: alarm[2] = 5; break;
		case 0: alarm[2] = 30; break;
	}
	menu_timer ++;
}