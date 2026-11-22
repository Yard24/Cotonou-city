# Icône provisoire de Marina City : un zémidjan stylisé au coucher du soleil (dessin original).
from PIL import Image, ImageDraw
import sys
out = sys.argv[1]
K = 4                      # dessin 4 fois plus grand, puis réduit (bords lisses)
S = 432 * K
def fond():
    im = Image.new("RGBA", (S, S))
    d = ImageDraw.Draw(im)
    haut, bas = (18, 70, 96), (247, 150, 60)
    for y in range(S):
        t = y / S
        c = tuple(int(haut[i] + (bas[i] - haut[i]) * t) for i in range(3))
        d.line([(0, y), (S, y)], fill=c + (255,))
    # soleil bas sur l'horizon, et la lagune
    d.ellipse([S*0.30, S*0.46, S*0.70, S*0.86], fill=(255, 214, 92, 255))
    d.rectangle([0, S*0.70, S, S], fill=(26, 96, 128, 255))
    for i, y in enumerate([0.74, 0.80, 0.87, 0.94]):
        w = 0.16 - i * 0.025
        d.rectangle([S*(0.5-w), S*y, S*(0.5+w), S*(y+0.012)], fill=(255, 214, 92, 200))
    return im
def avant():
    im = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    u = S / 432.0
    def P(x, y): return (x*u, y*u)
    sombre, jaune, peau = (34, 30, 28, 255), (252, 200, 22, 255), (106, 62, 36, 255)
    # roues (dans le cercle sûr de 264 px au centre)
    for cx in (148, 284):
        d.ellipse([P(cx-38, 262-38), P(cx+38, 262+38)], fill=sombre)
        d.ellipse([P(cx-14, 262-14), P(cx+14, 262+14)], fill=(170, 170, 170, 255))
    # cadre et réservoir
    d.polygon([P(148, 262), P(196, 214), P(262, 210), P(284, 262), P(262, 236), P(200, 240)], fill=(200, 40, 46, 255))
    d.polygon([P(196, 214), P(214, 196), P(258, 196), P(262, 210)], fill=(232, 60, 60, 255))
    d.line([P(262, 210), P(292, 168)], fill=sombre, width=int(10*u))      # fourche
    d.line([P(284, 168), P(306, 168)], fill=sombre, width=int(8*u))       # guidon
    d.rectangle([P(150, 200), P(212, 214)], fill=sombre)                   # selle
    # conducteur : chemise jaune de zémidjan, casque vert
    d.polygon([P(176, 202), P(204, 136), P(240, 136), P(226, 206)], fill=jaune)
    d.line([P(232, 148), P(288, 172)], fill=jaune, width=int(16*u))       # bras
    d.line([P(190, 204), P(232, 214), P(236, 250)], fill=(40, 52, 96, 255), width=int(18*u), joint="curve")   # jambe
    d.ellipse([P(206, 92), P(246, 132)], fill=peau)
    d.chord([P(202, 86), P(250, 128)], 180, 360, fill=(0, 135, 81, 255))
    return im
f, a = fond(), avant()
r = lambda im, n: im.resize((n, n), Image.LANCZOS)
r(f, 432).save(out + "/icone_fond_432.png")
r(a, 432).save(out + "/icone_avant_432.png")
tout = Image.alpha_composite(f, a)
r(tout, 192).save(out + "/icone_192.png")
