extends Control

@onready var line_edit: LineEdit = $ColorRect/user_input
@onready var label: Label = $ColorRect/user_output

func _ready() -> void:
	line_edit.text_submitted.connect(_on_LineEdit_text_entered)
	
func _on_LineEdit_text_entered(new_text: String) -> void:
	label.text = "Your name is: " + new_text
