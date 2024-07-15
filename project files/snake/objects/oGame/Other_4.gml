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
}