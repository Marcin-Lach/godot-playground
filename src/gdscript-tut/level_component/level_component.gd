extends ScriptNode
class_name LevelComponent


signal level_up(old_level:int, new_level: int)


@export var xpForLevelCalculationStrategy: LevelFormulaBase
var _current_xp : int
var _current_level : int:
	set(value):
		level_up.emit(_current_level, value)
		_current_level = value


func _init(_xpForLevelCalculationStrategy: LevelFormulaBase = null, _level: int = 1, _xp: int = 0):
	if _xpForLevelCalculationStrategy == null:
		_xpForLevelCalculationStrategy = LevelFormulaBase.new()
	
	xpForLevelCalculationStrategy = _xpForLevelCalculationStrategy
	_current_level = _level
	_current_xp = _xp

func calculate_xp_for_level(level: int):
	return xpForLevelCalculationStrategy.calculate_xp_level(level)

func add_xp(value: int):
	var call_identifier = randi()
	print("[" + str(call_identifier) + "] - " + "adding " + str(value) + "xp to level " + str(_current_level))
	
	var levels_gained: int = 0
	var level_snapshot: int = _current_level
	
	while value > 0:
		var processing_level = level_snapshot + levels_gained
		print("[" + str(call_identifier) + "] - " + "processing_level " + str(processing_level))
		
		var xp_after_adding_value = _current_xp + value 
		var xp_for_next_level = calculate_xp_for_level(processing_level)
		print("[" + str(call_identifier) + "] - " + "xp_after_adding_value " + str(xp_after_adding_value) + 
				"; xp_for_next_level " + str(xp_for_next_level))
		
		if xp_after_adding_value >= xp_for_next_level:
			print("will gain level!")
			value = xp_after_adding_value - xp_for_next_level
			levels_gained += 1
		else:
			break # not enough to get a level

	_current_xp = value
	_current_level += levels_gained


class Tests:
	var xpForLevel: int = 10
	
	func create_sut() -> LevelComponent:
		var level : LevelComponent = LevelComponent.new(LevelComponent_Test_XpFormulaStub.new(xpForLevel))
		return level

	func run_add_level_tests():
		_given_newLevelComponent_when_addingXpForExactly2Levels_then_gains2LevelsAndHave0xp()
		_given_newLevelComponent_when_addingXpForLessThanLevel_then_gains0LevelsAndHaveMoreThan0xp()
		
	func _given_newLevelComponent_when_addingXpForExactly2Levels_then_gains2LevelsAndHave0xp():
		print("running _given_newLevelComponent_when_addingXpForExactly2Levels_then_gains2LevelsAndHave0xp")
		var level : LevelComponent = create_sut()
		var xpFor2Levels = xpForLevel+xpForLevel
		
		_test_case_runner(level, xpFor2Levels, 3, 0)
		print("end")
	
	
	func _given_newLevelComponent_when_addingXpForLessThanLevel_then_gains0LevelsAndHaveMoreThan0xp():
		print("running _given_newLevelComponent_when_addingXpForLessThanLevel_then_gains0LevelsAndHaveMoreThan0xp")
		var level : LevelComponent = create_sut()
		var xpToadd = xpForLevel/2
		
		_test_case_runner(level, xpToadd, 1, xpToadd)
		print("end")


	func _test_case_runner(level: LevelComponent, xpToAdd: int, expectedLevel:int, expectedXp: int):
		var _isSuccess : bool = true
		level.add_xp(xpToAdd)

		print("expected current_level: " + str(expectedLevel) + "; actual level: " + str(level._current_level))
		if expectedLevel != level._current_level:
			_isSuccess = false

		print("expected current_xp: " + str(expectedXp) + "; actual current_xp: " + str(level._current_xp))
		if expectedXp != level._current_xp:
			_isSuccess = false
			
		if _isSuccess == false:
			print_rich("Test [color=red][b]Failed[/b][/color]!")
		else:
			print_rich("Test [color=green][b]Succeeded[/b][/color]!")

class LevelComponent_Test_XpFormulaStub:
	extends LevelFormulaBase
	
	var _constantXpForLevel: int
	
	func _init(constantXp: int = 10):
		_constantXpForLevel = constantXp

	func calculate_xp_level(_level: int):
		return _constantXpForLevel
