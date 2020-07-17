extends Node2D

signal dance_done

	
func start_dance():
	$"AnimationPlayer".play("ghost_movement")


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("dance_done")
