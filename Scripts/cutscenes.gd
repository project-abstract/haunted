extends Node2D

var count = 0

func _ready():
	$"AnimationPlayer".play("arrow_move")
	$"prot".texture = load("res://Resources/Prot/hero_"+ str(Global.prot_index) +".png")

func _on_text_bg_pressed():
	if count == 0:
		$"prot/text_bg/Label".text = "Cashier: Sorry, there must have been a mistake I will check the record for this order. In the mean time please look around and shop for some things you might want."
		count = 1
	elif count == 1:
		$"prot/text_bg".visible = false
		$"fwcolor".visible = true
		$"AnimationPlayer".play("world_start")
	elif count == 2:
		$"AnimationPlayer".play("ghost_kill")
		$"prot/text_bg/Label".text = "Cashier(speaking to oneself): What is that? I have to find the three guards. They have the cards to activate the wrap for exit. Now just need to .. AAAAAAAAA"
		count = 3
	elif count == 3:
		$"prot/text_bg".visible = false
	elif count == 4:
		$"prot/text_bg/Label".text = "The exit is locked. This is bad. I overheard the cashier saying there are three keys to reactivate the exit. I need to find the three keys."
		$"prot/text_bg".visible = false
		count = 5
	elif count == 5:
		$"prot/text_bg/Label".text = "I could also collect the items littered here to earn some quick cash outside."
		count = 6
	elif count == 6:
		$"prot/text_bg".visible = false
		get_tree().change_scene("res://Scenes/basic.tscn")

func _on_skip_button_pressed():
	get_tree().change_scene("res://Scenes/basic.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "world_start":
		$"CanvasModulate".visible = true
		$"fwcolor".visible = false
		$"prot/Light2D".visible = true
		$"eye".visible = true
		$"AnimationPlayer".play("eye_open")
	elif anim_name == "eye_open":
		$"prot/text_bg/Label".text = "Eye: Go my children play and train for as much you want."
		$"prot/text_bg".visible = true
		count = 2
	elif anim_name == "ghost_kill":
		$"eye".visible = false
		$"explosion".visible = true
		$"explosion2".visible = true
		$"explosion3".visible = true
		$"npc1".visible = false
		$"npc2".visible = false
		$"npc3".visible = false
		$"AnimationPlayer".play("explode")
	elif anim_name == "explode":
		$"explosion".visible = false
		$"explosion2".visible = false
		$"explosion3".visible = false
		$"AnimationPlayer".play("trying_to_excape")
		$"prot/Light2D".shadow_enabled = true
	elif anim_name == "trying_to_excape":
		print("ok")
		$"prot/text_bg/Label".text = "The exit is locked. This is bad. I overheard the cashier saying there are three keys to reactivate the exit. I need to find the three keys."
		$"prot/text_bg".visible = true
		count = 5
