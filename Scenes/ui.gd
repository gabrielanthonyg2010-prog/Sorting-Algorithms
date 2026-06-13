extends Control

@onready var sorter: Node2D = $".."
@onready var bogosort: Button = $"HBoxContainer/SORT TYPE/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer/BOGOSORT"
@onready var bubble: Button = $"HBoxContainer/SORT TYPE/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer/BUBBLE"
@onready var insert: Button = $"HBoxContainer/SORT TYPE/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer/INSERT"
@onready var select: Button = $"HBoxContainer/SORT TYPE/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer/SELECT"
@onready var stalin: Button = $"HBoxContainer/SORT TYPE/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer/STALIN"
@export var sort = sortType.select
enum sortType {
	bogosort,
	bubble,
	insert,
	select,
	stalin,
}
var numberOfBars : int
var speed := 1
func _on_bogosort_pressed() -> void:
	sort = sortType.bogosort
	bogosort.button_pressed = true
	bubble.button_pressed = false
	insert.button_pressed = false
	select.button_pressed = false
	stalin.button_pressed = false


func _on_bubble_pressed() -> void:
	sort = sortType.bubble
	bogosort.button_pressed = false
	bubble.button_pressed = true 
	insert.button_pressed = false
	select.button_pressed = false
	stalin.button_pressed = false


func _on_insert_pressed() -> void:
	sort = sortType.insert
	bogosort.button_pressed = false
	bubble.button_pressed = false
	insert.button_pressed = true
	select.button_pressed = false
	stalin.button_pressed = false

func _on_select_pressed() -> void:
	sort = sortType.select
	bogosort.button_pressed = false
	bubble.button_pressed = false
	insert.button_pressed = false
	select.button_pressed = true
	stalin.button_pressed = false


func _on_stalin_pressed() -> void:
	sort = sortType.stalin
	bogosort.button_pressed = false
	bubble.button_pressed = false
	insert.button_pressed = false
	select.button_pressed = false
	stalin.button_pressed = true

func _on_start_pressed() -> void:
	if numberOfBars:
		sorter.sort()


func _on_speed_text_changed(new_text: String) -> void:
	speed = int(new_text)


func _on_bars_text_changed(new_text: String) -> void:
	numberOfBars = int(new_text)
	print(numberOfBars)
