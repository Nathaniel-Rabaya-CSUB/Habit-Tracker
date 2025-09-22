extends Control

@onready var line_edit = $ColorRect/option
@onready var add_button = $ColorRect/add_option
@onready var label_container = $ColorRect/ScrollContainer/vContainer

func _ready() -> void:
	add_button.pressed.connect(_on_add_option_pressed)

func _on_add_option_pressed() -> void:
	create_new_label(line_edit.text)
	line_edit.clear()

func create_new_label(label_text):
	if label_text.is_empty():
		return
	
	var new_label = Label.new()
	new_label.text = label_text
	label_container.add_child(new_label)


func _on_remove_option_pressed() -> void:
	pass # Replace with function body.
