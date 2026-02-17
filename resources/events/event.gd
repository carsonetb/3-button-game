@abstract
class_name Event
extends Resource 

@export var happens_at: TimeUnit

var applied: bool = false

@abstract 
func apply(level: Level) -> void
