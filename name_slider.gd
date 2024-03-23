extends Control

const SLIDER := preload('res://slider.tscn') as PackedScene
const ALPHABET := ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

@export var slider_container: Container
@export var characters_slider: HSlider
@export var result_label: Label

func _ready() -> void:
	_on_characters_value_changed(characters_slider.value)

func _on_slider_changed(value: float, i: int) -> void:
	result_label.text = result_label.text \
		.erase(i) \
		.insert(i, ALPHABET[int(value)])

func _on_characters_value_changed(v: float) -> void:
	var value := int(v)
	var prev_value := slider_container.get_child_count()
	var diff := value - prev_value

	if diff < 0:
		for i in absi(diff):
			slider_container.get_child(slider_container.get_child_count()-1).queue_free()
	else:
		for i in diff:
			var instance := SLIDER.instantiate() as CustomSlider
			instance.slider.value_changed.connect(_on_slider_changed.bind(slider_container.get_child_count()))
			slider_container.add_child(instance)

	result_label.text = result_label.text.left(value).rpad(value, '_')
