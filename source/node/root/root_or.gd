extends Sprite
	
signal can_produce(node_position)

signal use_chenk
signal node_change

var is_run = false
var node_occupy = [0,0,0]
var nodes = []

func _ready():
	connect("can_produce",self,"can_produce")
	connect("use_chenk",self,"chenk")
	pass

func chenk():
	if is_run:
		if nodes[0].state or nodes[1].state:
			nodes[2].state = false
		else:
			nodes[2].state = true
			
		emit_signal("node_change")
		pass

	pass


func _process(delta):
	if node_occupy[0]==1 and node_occupy[1]==1:
		emit_signal("can_produce",2)
		pass
	if node_occupy[1]==1 and node_occupy[2]==1:
		emit_signal("can_produce",0)
		pass
	if node_occupy[0]==1 and node_occupy[2]==1:
		emit_signal("can_produce",1)
		pass
	pass

func can_produce(node_position):
	nodes[0].connect("is_change",self,"chenk")
	nodes[1].connect("is_change",self,"chenk")
	
	nodes.append(preload("res://node/01node/node.tscn").instance())
	if node_position == 0:
		var temp_position = $Area2D/CollisionShape2D.position
		nodes[2].position.x = int(temp_position.x/64)*64+64
		nodes[2].position.y = int(temp_position.y/64)*64+64
		
	if node_position == 1:
		var temp_position = $Area2D2/CollisionShape2D.position
		nodes[2].position.x = int(temp_position.x/64)*64+64
		nodes[2].position.y = int(temp_position.y/64)*64
		
	if node_position == 2:
		var temp_position = $Area2D3/CollisionShape2D.position
		nodes[2].position.x = int(temp_position.x/64)*64+64
		nodes[2].position.y = int(temp_position.y/64)*64
	
	nodes[2].parent.append($".")
	
	nodes[2].get_node("Particles2D").hide()	
	add_child(nodes[2])
	disconnect("can_produce",self,"can_produce")
	is_run = true
	emit_signal("use_chenk")
	pass

func _on_Area2D_area_entered(area):
	node_occupy[0]=1
	nodes.append(area.get_parent())
	print("o0")
	pass


func _on_Area2D2_area_entered(area):
	node_occupy[1]=1
	nodes.append(area.get_parent())
	print("o1")
	pass 


func _on_Area2D3_area_entered(area):
	node_occupy[2]=1
	nodes.append(area.get_parent())
	print("o2")
	pass 
