extends Label

func _ready():
	pass



func _process(delta):
	if get_parent().get_node("level_base").get_node("UI").get_node("root").texture.pause == false:
		visible = false
	pass

