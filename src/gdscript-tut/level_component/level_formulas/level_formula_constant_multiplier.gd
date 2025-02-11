extends LevelFormulaBase

class_name LevelFormulaConstantMultiplier

@export var multiplier: int

func _init(multiplier: int = 1) -> void:
	multiplier = multiplier
	
func calculate_xp_level(level: int) -> int:
	return level * multiplier


class Tests:
	func run_tests() -> void:
		print("running LevelFormulaConstantMultiplier_Tests")
		test_component()
		print("end")
		
	func test_component() -> void:
		_test_case_runner(10, 1, 10)
		_test_case_runner(100, 4, 400)
		_test_case_runner(123, 92, 11316)
		_test_case_runner(1938, 321, 622098)
	
	
	func _test_case_runner(multiplier: int, level: int, expectedValue: int) -> void:
		print("running test case for multiplier " + str(multiplier) + ", level " + str(level) + ", expectedValue " + str(expectedValue))
		var sut = LevelFormulaConstantMultiplier.new(multiplier)
		
		var result = sut.calculate_xp_level(level)
		
		if result != expectedValue:
			print_rich("Test [color=red][b]Failed[/b][/color]!")
		else:
			print_rich("Test [color=green][b]Succeeded[/b][/color]!")
