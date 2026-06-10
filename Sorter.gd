extends Node2D

const marginStart = 30.0
const barSeparation = 5
const borderD = 648.0
var bar = preload("res://bar.tscn")
var barHeights := {}
var sortedBars := []
var bars := []
var width : float
enum sortType {
	bogosort,
	select,
	insert,
	bubble
}
var sort = sortType.bogosort

func add_bars(numberOfBars):
	width = ((borderD - marginStart * 2) - barSeparation * (numberOfBars - 1)) / numberOfBars
	print(width)
	for i in range(numberOfBars):
		var new_bar = bar.instantiate()
		get_parent().add_child.call_deferred(new_bar)
		new_bar.position = Vector2(marginStart+(barSeparation+width)*i,borderD-4)
		new_bar.scale.y = i+1
		new_bar.scale.x = width/10
		sortedBars.append(new_bar)
		bars.append(new_bar)
		barHeights[new_bar] = i+1
		print("scale.x: ", new_bar.scale.x)
		print("rendered width: ", new_bar.scale.x * 10)
	print("width: ", width)
	print("last bar right edge: ", marginStart + (width + barSeparation) * (numberOfBars - 1) + width)
	print("expected right edge: ", borderD - marginStart)


func random_sort():
	randomize()
	
	bars.shuffle()
	for i in range(len(bars)):
		bars[i].position = Vector2(marginStart+barSeparation*i,borderD-4)

func _ready():
	add_bars(10)
	#random_sort()
	#$"Sort Delay".start()

func _on_sort_delay_timeout() -> void:
	if not is_same(sortedBars,bars):
		match sort:
			sortType.bogosort:
				random_sort()
			sortType.select:
				pass
			sortType.insert:
				pass
			sortType.bubble:
				pass
		$"Sort Delay".start()
