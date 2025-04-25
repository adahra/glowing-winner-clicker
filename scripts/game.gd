extends VBoxContainer

# Variabel untuk menyimpan nilai
var positive_balance: int = 50
var negative_balance: int = 50
var balance_threshold: int = 100

# Variabel upgrade
var positive_idle_rate: int = 1
var negative_idle_rate: int = 1
var positive_click_effect: int = 1
var negative_click_effect: int = 1
var upgrade_cost: int = 20

@onready var timer = $Timer

func _ready() -> void:
	update_ui()
	timer.start()

func update_ui() -> void:
	$VBoxContainer2/PositiveLabel.text = "Positive: %d" % positive_balance
	$VBoxContainer2/NegativeLabel.text = "Negative: %d" % negative_balance
	$VBoxContainer2/UpgradeCostLabel.text = "Upgrade Cost: %d" % upgrade_cost

# Fungsi untuk memeriksa apakah keseimbangan terjaga
func check_balance():
	if abs(positive_balance - negative_balance) > balance_threshold:
		game_over()

# Fungsi untuk mengakhiri permainan
func game_over():
	$GameOverLabel.text = "Game Over! Balance lost."
	
	$VBoxContainer/HBoxContainer/PositiveButton.disabled = true
	$VBoxContainer/HBoxContainer/NegativeButton.disabled = true
	$VBoxContainer/HBoxContainer/UpgradeButton.disabled = true
	
	timer.stop()

func _on_positive_button_pressed() -> void:
	positive_balance += positive_click_effect
	negative_balance -= negative_click_effect
	check_balance()
	update_ui()


func _on_negative_button_pressed() -> void:
	negative_balance += negative_click_effect
	positive_balance -= positive_click_effect
	check_balance()
	update_ui()


func _on_upgrade_button_pressed() -> void:
	if positive_balance >= upgrade_cost and negative_balance >= upgrade_cost:
		positive_balance -= upgrade_cost
		negative_balance -= upgrade_cost
		positive_idle_rate += 1
		negative_idle_rate += 1
		positive_click_effect += 1
		negative_click_effect += 1
		upgrade_cost += 10
		update_ui()


func _on_timer_timeout() -> void:
	positive_balance += positive_idle_rate
	negative_balance += negative_idle_rate
	check_balance()
	update_ui()
