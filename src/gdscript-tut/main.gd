extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text="Hello, world!"

var health: int = 100

func _input(event: InputEvent) -> void:
	if (event.is_action("my_action")):
		health -= 20
		print(health)
		


var level: LevelComponent = LevelComponent.new()

#func _on_timer_timeout() -> void:
	#var xp = randi_range(0, 1000000); 
	#level.add_xp(xp)

class LevelComponent:
	signal level_up(old_level:int, new_level: int)
	
	var _current_level : int = 1:
		set(value):
			level_up.emit(_current_level, value)
			_current_level = value
			
	var _current_xp : int = 0
	
	func xp_for_level_formula(level: int):
		return 20 * level
	
	func add_xp(value: int):
		var call_identifier = randi()
		print("[" + str(call_identifier) + "] - " + "adding " + str(value) + "xp to level " + str(_current_level))
		
		var levels_gained: int = 0
		var level_snapshot: int = _current_level
		
		while value > 0:
			var processing_level = level_snapshot + levels_gained
			print("[" + str(call_identifier) + "] - " + "processing_level " + str(processing_level))
			
			var xp_after_adding_value = _current_xp + value 
			var xp_for_next_level = xp_for_level_formula(processing_level)
			print("[" + str(call_identifier) + "] - " + "xp_after_adding_value " + str(xp_after_adding_value) + 
					"; xp_for_next_level " + str(xp_for_next_level))
			
			value = xp_after_adding_value - xp_for_next_level
			if value >= 0:
				levels_gained += 1
				_current_xp = 0
				continue
				
			_current_xp = xp_after_adding_value
			_current_level += levels_gained
			
			
class LevelComponent_Tests:
	func run_add_level_tests():
		var level : LevelComponent = LevelComponent.new()
		
		# Level-up formula is hard-coded and the test have to know how to calculate it
		# it should be decoupled, stubable, so that I can create test stub for the formula
		# then it would be independent from logic changes
		# it would also allow for handling multiple strategies for calculating xp required for level-up 
		level.add_xp(20+40+1)
		
		print("expected current_level: 3; actual level: " + str(level._current_level))
		print("expected current_xp: 1; actual current_xp: " + str(level._current_xp))


func _on_button_pressed() -> void:
	var levelComponentTests = LevelComponent_Tests.new()
	levelComponentTests.run_add_level_tests()
