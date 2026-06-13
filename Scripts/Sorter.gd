extends Node2D

@onready var control: Control = $Control

const marginStart = 30.0
const barSeparation = 5
const borderD = 648.0
const borderR = 1152.0
var bar = preload("res://Scenes/bar.tscn")
var barHeights := {}
var bars := []
var sortedBars := []
var width : float
var heightDif : float
var stop := false
var startable := true
var speed: int
enum sortType {
	bogosort,
	bubble,
	insert,
	select,
	stalin,
}

func _process(_delta: float) -> void:
	speed = control.speed

func add_bars(numberOfBars):
	width = ((borderR - marginStart * 2) - barSeparation * (numberOfBars - 1)) / numberOfBars
	heightDif = (borderD-600)/numberOfBars
	for i in range(numberOfBars):
		var new_bar = bar.instantiate()
		get_parent().add_child.call_deferred(new_bar)
		new_bar.position = Vector2(marginStart+(barSeparation+width)*i,borderD-4)
		new_bar.scale.y = (i+1)*heightDif
		new_bar.scale.x = width/10
		sortedBars.append(new_bar)
		bars.append(new_bar)
		barHeights[new_bar] = i+1


func random_sort():
	randomize()
	
	bars.shuffle()
	for i in range(len(bars)):
		move_bars(i)

func bogosort():
	print("bogo")
	while not sortedBars == bars:
		random_sort()
		@warning_ignore("integer_division")
		for i in range(6/speed):
			await get_tree().process_frame
	for z in range(len(bars)):
		move_bars(z)
		change_color(z,"GREEN")
	stop = false
	startable = true

func select_sort():
	var smallest_height
	var smallest_bar
	var smallest_position
	for i in range(len(bars)):
		change_color(i,"WHITE")
		smallest_height = barHeights[bars[i]]
		for checkbar in range(i+1,len(bars)):
			change_color(checkbar,"BLUE")
			if barHeights[bars[checkbar]] < smallest_height:
				smallest_height = barHeights[bars[checkbar]]
				smallest_bar = bars[checkbar]
			@warning_ignore("integer_division")
			for x in range(6/speed):
				await get_tree().process_frame
			change_color(checkbar,"WHITE")
		if not smallest_height == barHeights[bars[i]]:
			smallest_position = bars.find(smallest_bar)
			bars.set(smallest_position,bars[i])
			bars.set(i,smallest_bar)
		for z in range(len(bars)):
			move_bars(z)
			change_color(z,"WHITE")
		@warning_ignore("integer_division")
		for x in range(6/speed):
			await get_tree().process_frame
	for z in range(len(bars)):
		move_bars(z)
		change_color(z,"GREEN")
	stop = false
	startable = true

func insertion_sort():
	#This is for like the farthest part of the "ordered" sort
	for i in range(len(bars)-1):
		var lastPos = 0
		var nextbar = bars[i+1]
		change_color(i,"RED")
		#if the bar after the sort is greater than the last part of the sorted then it inserts it at the end
		@warning_ignore("integer_division")
		for x in range(12/speed):
			await get_tree().process_frame
		if stop == true:
			return
		if barHeights[nextbar] > barHeights[bars[i]]:
			continue
		#This checks every part of the "ordered sort"
		for c in range(i,-1,-1):
			#if the bar is smaller than the bar its checking then insert there if it isnt then continue the loop
			change_color(c,"BLUE")
			if stop == true:
				return
			if barHeights[nextbar] < barHeights[bars[c]]:
				lastPos = c
			if barHeights[nextbar] > barHeights[bars[c]]:
				break
			@warning_ignore("integer_division")
			for x in range(6/speed):
				await get_tree().process_frame
		bars.erase(nextbar)
		bars.insert(lastPos,nextbar)
		for z in range(len(bars)):
			move_bars(z)
			change_color(z,"WHITE")
		@warning_ignore("integer_division")
		for x in range(12/speed):
			await get_tree().process_frame
	for z in range(len(bars)):
		move_bars(z)
		change_color(z,"GREEN")
	stop = false
	startable = true

func bubble_sort():
	var rounds = 0
	while true:
		var swaps = 0
		for i in range(len(bars)-(rounds+1)):
			change_color(i,"RED")
			if barHeights[bars[i]] > barHeights[bars[i+1]]:
				var A = bars[i]
				var B = bars[i+1]
				bars.set(i,B)
				bars.set(i+1,A)
				change_color(i,"WHITE")
				for z in range(len(bars)):
					move_bars(z)
				swaps+=1
				@warning_ignore("integer_division")
				for x in range(6/speed):
					await get_tree().process_frame
				for z in range(len(bars)):
					move_bars(z)
					change_color(z,"WHITE")
		@warning_ignore("integer_division")
		for x in range(6/speed):
			await get_tree().process_frame
		for z in range(len(bars)):
			move_bars(z)
			change_color(z,"WHITE")
		if swaps == 0:
			break
	for z in range(len(bars)):
		move_bars(z)
		change_color(z,"GREEN")
	stop = false
	startable = true

func stalin_sort():
	var index = 0
	while true and not stop:
		change_color(index,"RED")
		if barHeights[bars[index]] > barHeights[bars[index+1]]:
			bars[index+1].position = Vector2(1000000,1000000000000)
			bars.erase(bars[index+1])
		else:
			change_color(index,"WHITE")
			index += 1
		for z in range(len(bars)):
			move_bars(z)
		@warning_ignore("integer_division")
		for x in range(6/speed):
			await get_tree().process_frame
		if index == len(bars)-1:
			break
	for z in range(len(bars)):
		move_bars(z)
		change_color(z,"GREEN")
	stop = false
	startable = true

func move_bars(barIndex):
	if not stop:
		bars[barIndex].position = Vector2(marginStart+(barSeparation+width)*barIndex,borderD-4)

func change_color(barIndex,color):
	if not stop:
		bars[barIndex].modulate = color

func sort():
	if startable:
		startable = false
		stop = true
		for x in range(len(bars)):
			bars[0].queue_free()
			barHeights.erase(bars[0])
			sortedBars.remove_at(0)
			bars.remove_at(0)
		stop = false
		barHeights = {}
		sortedBars = []
		bars = []
		add_bars(control.numberOfBars)
		for x in range(60):
			await get_tree().process_frame
		for x in range(1):
			random_sort()
			for z in range(1):
				await get_tree().process_frame
		for x in range(12):
			await get_tree().process_frame
		if not sortedBars == bars:
			startable = false
			match control.sort:
				sortType.bogosort:
					bogosort()
				sortType.select:
					select_sort()
				sortType.insert:
					insertion_sort()
				sortType.bubble:
					bubble_sort()
				sortType.stalin:
					stalin_sort()
		else:
			random_sort()
