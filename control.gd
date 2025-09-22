extends Control # notifies what part of the script is connected to in scene

# create variables designated to scene nodes
# @onready = used only when needed
@onready var line_edit = $ColorRect/option
@onready var add_button = $ColorRect/add_option
@onready var list_container = $ColorRect/ScrollContainer/vContainer

func _ready() -> void:
	add_button.pressed.connect(_on_add_option_pressed) # connect add_button function -> scene node

func _on_add_option_pressed() -> void: # function: add_button is pressed
	create_new_item(line_edit.text)
	line_edit.clear()

func create_new_item(item_text): # function: create new item in list
	if item_text.is_empty(): # check if empty
		print("Please input an option") # DEBUG
	list_container.add_item(item_text) # add item to list

func _on_remove_option_pressed() -> void: # function: remove_button is pressed
	if list_container.item_count == 0: # check if list is empty
		print("List is empty") # DEBUG
		return
	var selectedItem = list_container.get_selected_items() # return pointer to selected item\
	if selectedItem.size() > 0: # selectedItem = array, size() only for arrays
		var removeIndex = selectedItem[0] # dereference pointer
		list_container.remove_item(removeIndex) # remove selected index
	else:
		print("Select an item to remove") # DEBUG
