extends Node

const UPPER_LEFT: String = "[color=white]╭[/color]"
const UPPER_RIGHT: String = "[color=white]╮[/color]"
const BOTTOM_LEFT: String = "[color=white]╰[/color]"
const BOTTOM_RIGHT: String = "[color=white]╯[/color]"
const HORIZONTAL: String = "[color=white]─[/color]"
const VERTICAL: String = "[color=white]│[/color]"

enum LogLevel { 
	DEBUG,
	INFO,
	WARNING,
	ERROR
}

var rtl := RichTextLabel.new()
var logger: DebugLogger = DebugLogger.new("Logging")

func _ready() -> void:
	logger.initialize()

func initialize(system: String) -> void:
	print_rich(generate_box(loggify("Initialized!", system, LogLevel.INFO)))

func debug(system: String, contents: String, remove_amm: int = 0) -> void:
	print_log(system, contents, LogLevel.DEBUG, remove_amm + 1)

func info(system: String, contents: String, remove_amm: int = 0) -> void:
	print_log(system, contents, LogLevel.INFO, remove_amm + 1)

func warning(system: String, contents: String, remove_amm: int = 0) -> void:
	print_log(system, contents, LogLevel.WARNING, remove_amm + 1)

func error(system: String, contents: String, remove_amm: int = 0) -> void:
	print_log(system, contents, LogLevel.ERROR, remove_amm + 1)

func print_log(system: String, contents: String, level: LogLevel, remove_amm: int = 0) -> void:
	if level == LogLevel.ERROR:
		var with_info: String = contents + pretty_stack(remove_amm + 1)
		print_rich(generate_box(loggify(with_info.rstrip("\n"), system, level)))
	elif level == LogLevel.WARNING:
		print_rich(loggify(contents + pretty_stack(remove_amm + 1), system, level))
	else:
		print_rich(loggify(contents, system, level))

func pretty_stack(remove_amm: int = 0) -> String:
	var trace: String = "\nStack trace (most recent call first):\n"
	for frame: Dictionary in get_stack().slice(remove_amm + 1, get_stack().size()):
		trace += "    {0}:{1} in {2}\n".format([frame["source"], frame["line"], frame["function"]])
	return trace.rstrip("\n")

func loggify(contents: String, system: String, level: LogLevel) -> String:
	var level_text: String
	var color: Color
	match level:
		LogLevel.DEBUG:
			level_text = "DEBUG"
			color = Color.SKY_BLUE
		LogLevel.INFO:
			level_text = "INFO"
			color = Color.PALE_GREEN
		LogLevel.WARNING:
			level_text = "WARNING"
			color = Color.YELLOW
		LogLevel.ERROR:
			level_text = "ERROR"
			color = Color.RED
	var time := Time.get_time_string_from_system()
	var header := "[lb][i]{0}[/i][rb] [lb][i]{1}[/i][rb] [lb][b]{2}[/b][rb]".format([time, system, level_text])
	var header_length := get_text_length(header)
	var lines := contents.split("\n")
	var out: String = ""
	for i in range(lines.size()):
		var line: String = lines[i]
		if i == 0:
			out += ("{0} {1}\n".format([header, line]))
		else:
			out += ("{0} {1}\n".format([".".repeat(header_length), line]))
	return colorize(out.rstrip("\n"), color)

func colorize(contents: String, color: Color) -> String:
	var out: String = ""
	var lines := contents.split("\n")
	for line in lines:
		out += "[color={0}]{1}[/color]\n".format([color.to_html(false), line])
	return out.substr(0, out.length() - 1)

func generate_box(contents: String, vpadding: int = 1, hpadding: int = 0) -> String:
	var out: String = ""
	var lines := contents.split("\n")
	var width: int = 0
	var height: int = len(lines)
	for line in lines:
		if get_text_length(line) > width:
			width = get_text_length(line)
	var real_width: int = width + vpadding * 2
	var real_height: int = height + hpadding * 2
	out += UPPER_LEFT + HORIZONTAL.repeat(real_width) + UPPER_RIGHT + "\n"
	for i in range(hpadding):
		out += (VERTICAL + " ".repeat(real_width)) + "\n"
	var padding: String = " ".repeat(vpadding)
	for line in lines:
		out += (VERTICAL + padding + line + " ".repeat(width - get_text_length(line)) + padding + VERTICAL) + "\n"
	for i in range(hpadding):
		out += (VERTICAL + " ".repeat(real_width)) + "\n"
	out += (BOTTOM_LEFT + HORIZONTAL.repeat(real_width) + BOTTOM_RIGHT)
	return out

func get_text_length(text: String) -> int:
	rtl.bbcode_enabled = true
	rtl.text = text
	return rtl.get_total_character_count()
