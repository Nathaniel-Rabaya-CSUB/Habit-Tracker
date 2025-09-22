extends Control # notifies what part of the script is connected to in scene

var rng = RandomNumberGenerator.new() # create random function
var interalArray = []

# create variables designated to scene nodes
# @onready = used only when needed
@onready var option_edit = $ColorRect/option
@onready var weight_edit = $ColorRect/weight
@onready var add_button = $ColorRect/add_option
@onready var list_container = $ColorRect/ScrollContainer/vContainer

func _ready() -> void:
	add_button.pressed.connect(_on_add_option_pressed) # connect add_button function -> scene node

func _on_add_option_pressed() -> void: # function: add_button is pressed
	create_new_item(option_edit.text, weight_edit.text) # create new item in list	

func create_new_item(item_text, weight_text): # function: create new item in list
	if item_text.is_empty(): # check if empty
		print("Please input an option") # DEBUG
		option_edit.edit() # autoset to typing in box
		return
	
	elif weight_text.is_valid_int() == false:
		print("Please input a number") # DEBUG
		weight_edit.clear()
		weight_edit.edit()
		return
	
	for n in int(weight_text):
		interalArray.append(item_text)
		print(interalArray[n])
	
	list_container.add_item(item_text + " (" + String(weight_text) + ")") # add item to list
	option_edit.clear() # clear current text
	option_edit.edit() # autoset to typing in box

func _on_remove_option_pressed() -> void: # function: remove_button is pressed
	if list_container.item_count == 0: # check if list is empty
		print("List is empty") # DEBUG
		return
	var selectedItem = list_container.get_selected_items() # return pointer to selected item
	if selectedItem.size() > 0: # selectedItem = size of array, size() only for arrays
		var removeIndex = selectedItem[0] # dereference pointer
		list_container.remove_item(removeIndex) # remove selected index
	else:
		print("Select an item to remove") # DEBUG
		return

func _on_choice_option_pressed() -> void:
	if list_container.item_count == 0: # check if list is empty
		print("List is empty") # DEBUG
		return
	
	var randIdx = rng.randi_range(0, list_container.item_count)
