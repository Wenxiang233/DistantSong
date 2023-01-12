extends Node
class_name Filter


var FunctionalGraph = load("res://class/functionalSystem/FunctionalGraph.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")

var graph
var param_map

func exec(params_):
	var params = params_.depulicate()

	for index in range(params.size()):
		__swap(index, param_map[index], params)

	return graph.exec(params)

func setGraph(graph_):
	TypeUnit.isType(graph_, "FunctionalGraph")
	graph = graph_

func getGraph():
	return graph

func setParamMap(map):
	var params_type = graph.getParamsType()
	__verifyMap(map, params_type.size())
	param_map = map

func getParamMap():
	return param_map

func getParamsType():
	var params_type = graph.getParamsType()

	for index in range(params_type.size()):
		__swap(index, param_map[index], params_type)
	
	return params_type

func getRetRequirement():
	return graph.getRetType()

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("graph", graph)

	return script_tree

func loadScript(script_tree):
	graph = script_tree.loadObject("graph", FunctionalGraph)

func __swap(first, second, arr):
	Exception.assert(first < arr.size())
	Exception.assert(second < arr.size())

	var tmp = arr[first]
	arr[first] = arr[second] 
	arr[second] = tmp

func __verifyMap(map, size):
	if map.size() != size:
		return false

	var arr = []
	arr.resize(map.size())

	for index in map.size():
		if map[index] > arr.size():
			return false
		if arr[map[index]] == null:
			arr[map[index]] = map[index]
		else:
			return false
	
	return true
