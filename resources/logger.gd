class_name DebugLogger
extends Resource

var system: String

func _init(_system: String) -> void:
	system = _system

func initialize() -> void:
	Logging.initialize(system)

func debug(contents: String) -> void:
	Logging.debug(system, contents, 1)

func info(contents: String) -> void:
	Logging.info(system, contents, 1)

func warning(contents: String) -> void:
	Logging.warning(system, contents, 1)

func error(contents: String) -> void:
	Logging.error(system, contents, 1)
