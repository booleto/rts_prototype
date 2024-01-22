extends CanvasLayer

@onready var money_label : Label = $MarginContainer/PanelContainer2/VSplitContainer/Label
@onready var panel_des : Label = $MarginContainer/PanelContainer/HSplitContainer/MarginContainer/HFlowContainer/Description
@onready var panel_img : TextureRect = $MarginContainer/PanelContainer/HSplitContainer/Image

func _ready():
	money_label.visible = true
	panel_des.visible = false
	panel_img.visible = false

func update_panel_texture(texture : Texture2D) -> void:
	panel_img.texture = texture

func update_topleft_label(text : String) -> void:
	money_label.text = text
	
func update_panel_description(text : String) -> void:
	panel_des.text = text
	
func display_unit(unit : UnitData) -> void:
	update_panel_texture(unit.texture)
	update_panel_description(unit.description)
	panel_des.visible = true
	panel_img.visible = true
	
func hide_panel() -> void:
	panel_des.visible = false
	panel_img.visible = false
