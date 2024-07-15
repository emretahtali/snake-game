if (room == r0)
{
	head = instance_create_layer(512, 384, "Player", oNode);
	var node = head;
	
	for (var i = 1; i < 5; i++)
	{
		node.prev = instance_create_layer(512 - i*cell_size, 384, "Player", oNode);
		node.prev.next = node;
		node = node.prev;
	}
	tail = node;
	
	// reset the room
	global.game_score = 0;
	frame = 0;
	timer = 0;
	last_move = 3;
	ds_queue_clear(move_list);
}