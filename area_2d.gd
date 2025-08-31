extends Area2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D and body.has_method("become_knight"):
		body.become_knight()
