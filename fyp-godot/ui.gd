extends Control

onready var score_cont = get_node("Score")
onready var combo_cont = get_node("combo")
onready var hit_feedback_cont = get_node("accuracy_cont")
onready var max_combo_cont = get_node("max_combo")
onready var acc_cont = get_node("Acc")

var score
var score_acc
var combo
var max_combo = 0
var acc
var time = 0
var hit_notes_perfect
var hit_notes_great
var hit_notes_ok
var hit_notes_miss
var map

var final_stats

func _ready():
	reset()
	acc_cont.set_text(str(acc) + "%")
	score_cont.set_text(str(score))
	combo_cont.set_text(str(combo))
	max_combo_cont.set_text(str(max_combo))
	
func _process(_delta):
	if combo > max_combo:
		max_combo = combo
	calc_acc()
	acc_cont.set_text(str(acc) + "%")
	max_combo_cont.set_text(str(max_combo))
	score_cont.set_text(str(score))
	combo_cont.set_text(str(combo))
	
func reset():
	score = 0
	combo = 0
	acc = 0
	hit_notes_perfect = 0
	hit_notes_great = 0
	hit_notes_ok = 0
	hit_notes_miss = 0
	
	final_stats = {
		score = score, 
		combo = max_combo,
		accuracy = acc,
	}
	
func add_score():
	score = score + (score_acc +(score_acc * combo / 25))
	
# warning-ignore:shadowed_variable
func hit_continued_feedback(acc):
		acc = 4 - acc
		score = score + (acc * combo * 5)
		combo = combo + 1

func calc_acc():
	var total_notes = hit_notes_perfect + hit_notes_great + hit_notes_ok + hit_notes_miss
	if total_notes > 0:
		acc = (float(50 * hit_notes_ok) + (100 * hit_notes_great) + (300 * hit_notes_perfect)) / float(300 * (total_notes))
		acc = "%.2f" %(acc * 100)
		
func hit_feedback(accuracy):
	var value
	if accuracy == 1:
		value = 0 
		score_acc = 300
		combo = combo + 1
		hit_notes_perfect += 1
		combo_anim()
		hit_feedback_cont.hit_feedback(value)
	elif accuracy == 2:
		value = 1
		score_acc = 100
		combo = combo + 1
		hit_notes_great += 1
		combo_anim()
		hit_feedback_cont.hit_feedback(value)
	elif accuracy == 3:
		value = 2
		score_acc = 50
		combo =combo + 1
		hit_notes_ok += 1
		combo_anim()
		hit_feedback_cont.hit_feedback(value)
	elif accuracy == 4:
		if combo >= 30:
			$break.play()
		value = 3
		score_acc = 0
		combo = 0
		hit_notes_miss += 1
		hit_feedback_cont.hit_feedback(value)
	
func is_finished():
	final_stats = {
		score = score, 
		combo = max_combo,
		accuracy = acc,
		map = GAME_C.map_selected.song_folder
	}
	
	var note_stats = {
		hit_notes_perfect = hit_notes_perfect,
		hit_notes_great = hit_notes_great,
		hit_notes_ok = hit_notes_ok,
		hit_notes_miss = hit_notes_miss
	}
	
	GAME_C.map_done_score = final_stats
	GAME_C.note_stats = note_stats

func combo_anim():
	$AnimationPlayer.play("combo_anim")
