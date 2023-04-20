extends Area2D

var damageCount : float = 2

func _ready():
	body_entered.connect(on_body_entered)
	
func on_body_entered(body: Node2D):
	#print(body.name)
	if body is Enemy:
		var enemy : Enemy = body as Enemy
		enemy.apply_damage(damageCount)
		
	if body is Player:
		var player : Enemy = body as Enemy
		player.personal_damage(damageCount)
