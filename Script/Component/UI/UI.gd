extends CanvasLayer
class_name UIComponent

@onready var money_label : Label = $MarginContainer/TopleftContainer/VSplitContainer/Label

@onready var panel : PanelContainer = $MarginContainer/TooltipContainer
@onready var panel_des : Label = $MarginContainer/TooltipContainer/HSplitContainer/MarginContainer/HFlowContainer/Description
@onready var panel_img : TextureRect = $MarginContainer/TooltipContainer/HSplitContainer/Image

func _ready():
	money_label.visible = true
	panel.visible = false

func update_panel_texture(texture : Texture2D) -> void:
	panel_img.texture = texture

func update_topleft_label(text : String) -> void:
	money_label.text = text
	
func update_panel_description(text : String) -> void:
	panel_des.text = text

func hide_panel() -> void:
	panel.visible = false

func display_unit(unit : UnitData) -> void:
	update_panel_texture(unit.texture)
	update_panel_description(unit.description)
	panel.visible = true
	
