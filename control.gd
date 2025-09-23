extends Control # notifies what part of the script is connected to in scene

var rng = RandomNumberGenerator.new() # create random function
var interalArray = []

# create variables designated to scene nodes
# @onready = used only when needed
@onready var option_edit = $ColorRect/option
@onready var weight_edit = $ColorRect/weight
@onready var list_container = $ColorRect/ScrollContainer/vContainer
@onready var decision_pu = $"Decision Pop Up"
@onready var decision_pu_text = $"Decision Pop Up/ColorRect/decision"
@onready var error_pu = $"Error Pop Up"
@onready var error_pu_text = $"Error Pop Up/ColorRect/error"

func _ready() -> void:
	pass

func _on_add_option_pressed() -> void: # function: add_button is pressed
	create_new_item(option_edit.text, weight_edit.text) # create new item in list	

func create_new_item(item_text, weight_text): # function: create new item in list
	if item_text.is_empty(): # check if empty
		print("Please input an option") # DEBUG
		error_pu_text.text = "Please input an option"
		error_pu.show()
		option_edit.edit() # autoset to typing in box
		return
	
	elif item_text.contains("(") || item_text.contains(")"):
		print("Do not add parantheses")
		error_pu_text.text = "Do not add parantheses"
		error_pu.show()
		weight_edit.clear() # clear current text
		option_edit.clear() # clear current text
		option_edit.edit() # autoset to typing in box
		return
	
	elif weight_text.is_empty():
		weight_text = "1"
	
	elif weight_text.is_valid_int() == false || weight_text.to_int() <= 0:
		print("Please input a positive number") # DEBUG
		error_pu_text.text = "Please input a positive number"
		error_pu.show()
		weight_edit.clear() # clear current text
		weight_edit.edit() # autoset to typing in box
		return
	
	for n in int(weight_text): # for loop to add to internalArray
		interalArray.append(item_text) # add to internalArray
		print(interalArray[interalArray.size()-1]) # DEBUG
	
	list_container.add_item(item_text + " (" + String(weight_text) + ")") # add item to list
	weight_edit.clear() # clear current text
	option_edit.clear() # clear current text
	option_edit.edit() # autoset to typing in box

func _on_remove_option_pressed() -> void: # function: remove_button is pressed
	if list_container.item_count == 0: # check if list is empty
		print("List is empty") # DEBUG
		error_pu_text.text = "List is empty"
		error_pu.show()
		return
	var selectedItem = list_container.get_selected_items() # return pointer to selected item
	if selectedItem.size() > 0: # selectedItem = size of array, size() only for arrays
		var removeIndex = selectedItem[0] # dereference pointer
		var fullText = list_container.get_item_text(removeIndex)
		var editText # var to store string
		for n in fullText.length(): # for loop n -> fullText string size
			if(fullText[n] == "("): # find "(" in string
				editText = fullText.substr(0, n-1) # isolate start of text to space before "("
				print (editText) # DEBUG
		for n in range(interalArray.size()-1, -1, -1): # for loop interalArray.size()-1 > -1, i--
			if interalArray[n] == editText: # element == decision - weight string
				interalArray.remove_at(n) # remove from interalArray
		print(interalArray.size()) # DEBUG
		print(interalArray) # DEBUG
		list_container.remove_item(removeIndex) # remove selected index
	else:
		print("Select an item to remove") # DEBUG
		return

func _on_decide_option_pressed() -> void:
	if list_container.item_count == 0: # check if list is empty
		print("List is empty") # DEBUG
		error_pu_text.text = "List is empty"
		error_pu.show()
		return
	
	var randIdx = rng.randi_range(0, interalArray.size() - 1) # identify random index
	print("index: " + str(randIdx) + ": " + interalArray[randIdx]) # DEBUG
	decision_pu_text.text = "Your choice is: " + interalArray[randIdx]
	decision_pu.show()

func decision_ok_button_pressed() -> void:
	decision_pu.hide()

func error_ok_button_pressed() -> void:
	error_pu.hide()
