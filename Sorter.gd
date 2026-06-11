extends Node2D

const marginStart = 30.0
const barSeparation = 5
const borderD = 648.0
const borderR = 1152.0
var bar = preload("res://bar.tscn")
var barHeights := {}
var sortedBars := []
var bars := []
var width : float
var heightDif : float
enum sortType {
	bogosort,
	bubble,
	insert,
	select,
	stalin,
}
var sort = sortType.stalin

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

func select_sort():
	var smallest_height
	var smallest_bar
	var smallest_position
	for i in range(len(bars)):
		bars[i].modulate = "RED"
		smallest_height = barHeights[bars[i]]
		for checkbar in range(i+1,len(bars)):
			bars[checkbar].modulate = "BLUE"
			if barHeights[bars[checkbar]] < smallest_height:
				smallest_height = barHeights[bars[checkbar]]
				smallest_bar = bars[checkbar]
			for x in range(6):
				await get_tree().process_frame
			bars[checkbar].modulate = "WHITE"
		if not smallest_height == barHeights[bars[i]]:
			smallest_position = bars.find(smallest_bar)
			bars.set(smallest_position,bars[i])
			bars.set(i,smallest_bar)
		for z in range(len(bars)):
			move_bars(z)
			bars[z].modulate = "WHITE"
		for x in range(6):
			await get_tree().process_frame
	for z in range(len(bars)):
		move_bars(z)
		bars[z].modulate = "GREEN"

func insertion_sort():
	#This is for like the farthest part of the "ordered" sort
	for i in range(len(bars)-1):
		var lastPos = 0
		var nextbar = bars[i+1]
		bars[i].modulate = "RED"
		#if the bar after the sort is greater than the last part of the sorted then it inserts it at the end
		for x in range(12):
			await get_tree().process_frame
		if barHeights[nextbar] > barHeights[bars[i]]:
			print("next bar is higher than highest bar")
			continue
		#This checks every part of the "ordered sort"
		for c in range(i,-1,-1):
			#if the bar is smaller than the bar its checking then insert there if it isnt then continue the loop
			bars[c].modulate = "BLUE"
			for x in range(12):
				await get_tree().process_frame
			if barHeights[nextbar] < barHeights[bars[c]]:
				lastPos = c
			if barHeights[nextbar] > barHeights[bars[c]]:
				break
		print(lastPos)
		bars.erase(nextbar)
		bars.insert(lastPos,nextbar)
		for z in range(len(bars)):
			move_bars(z)
			bars[z].modulate = "WHITE"
		for x in range(12):
			await get_tree().process_frame
	for z in range(len(bars)):
		move_bars(z)
		bars[z].modulate = "GREEN"

func bubble_sort():
	var rounds = 0
	while true:
		var swaps = 0
		for i in range(len(bars)-(rounds+1)):
			bars[i].modulate = "RED"
			if barHeights[bars[i]] > barHeights[bars[i+1]]:
				var A = bars[i]
				var B = bars[i+1]
				bars.set(i,B)
				bars.set(i+1,A)
				bars[i].modulate = "WHITE"
				for z in range(len(bars)):
					move_bars(z)
				swaps+=1
				for x in range(6):
					await get_tree().process_frame
				for z in range(len(bars)):
					move_bars(z)
					bars[z].modulate = "WHITE"
		for x in range(6):
			await get_tree().process_frame
		for z in range(len(bars)):
			move_bars(z)
			bars[z].modulate = "WHITE"
		if swaps == 0:
			break
	for z in range(len(bars)):
		move_bars(z)
		bars[z].modulate = "GREEN"

func stalin_sort():
	var index = 0
	while true:
		bars[index].modulate = "RED"
		if barHeights[bars[index]] > barHeights[bars[index+1]]:
			bars[index+1].position = Vector2(1000000,1000000000000)
			bars.erase(bars[index+1])
		else:
			index += 1
		for z in range(len(bars)):
			move_bars(z)
		for x in range(6):
			await get_tree().process_frame
		if index == len(bars)-1:
			break
	for z in range(len(bars)):
		move_bars(z)
		bars[z].modulate = "GREEN"

func _ready():
	add_bars(50)
	for x in range(60):
		await get_tree().process_frame
	for x in range(1):
		random_sort()
		for z in range(1):
			await get_tree().process_frame
	for x in range(12):
		await get_tree().process_frame
	if not sortedBars == bars:
		match sort:
			sortType.bogosort:
				while not sortedBars == bars:
					random_sort()
					for i in range(6):
						await get_tree().process_frame
				for z in range(len(bars)):
					move_bars(z)
					bars[z].modulate = "GREEN"
			sortType.select:
				select_sort()
			sortType.insert:
				insertion_sort()
			sortType.bubble:
				bubble_sort()
			sortType.stalin:
				stalin_sort()

func move_bars(barIndex):
	bars[barIndex].position = Vector2(marginStart+(barSeparation+width)*barIndex,borderD-4)
