extends Control
# Indicateur de recherche : cinq étoiles (décision 73), dessinées sans police de caractères.
# Pleines jusqu'au niveau de recherche, en contour au-delà ; l'ensemble clignote quand la
# police a perdu le joueur de vue. Piloté par affichage.gd.

const NB := 5
const TAILLE := 30.0    # largeur d'une étoile, en pixels
const PAS := 36.0
var niveau := 0
var eteint := false     # moitié éteinte du clignotement

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	custom_minimum_size = Vector2(PAS * NB, TAILLE + 4.0)

func regler(n: int, off: bool) -> void:
	if n != niveau or off != eteint:
		niveau = n
		eteint = off
		queue_redraw()

static func points(c: Vector2, r: float) -> PackedVector2Array:
	var p := PackedVector2Array()
	for i in 10:
		var a := -PI / 2 + i * PI / 5
		p.append(c + Vector2(cos(a), sin(a)) * (r if i % 2 == 0 else r * 0.42))
	return p

func _draw() -> void:
	for i in NB:
		var c := Vector2(PAS * (i + 0.5), TAILLE / 2 + 2.0)
		var plein := i < niveau and not eteint
		draw_colored_polygon(points(c, TAILLE / 2 + 2.0), Color(0, 0, 0, 0.75))
		draw_colored_polygon(points(c, TAILLE / 2 - 1.0), Color("f5c400") if plein else Color(0.25, 0.25, 0.25, 0.9))
