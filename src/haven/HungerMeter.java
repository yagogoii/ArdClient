package haven;

import haven.sloth.gui.MovableWidget;

import java.awt.Color;

public class HungerMeter extends MovableWidget {
    private static final Tex bg = Resource.loadtex("hud/meter/hungermeter");

    private final CharWnd.GlutMeter glut;

    public HungerMeter(CharWnd.GlutMeter glut, final String name) {
        super(IMeter.fsz, name);
        this.glut = glut;
    }

    @Override
    public void draw(GOut g) {
        if (glut.bg == null)
            return;
        Coord isz = IMeter.msz;
        Coord off = IMeter.off;
        g.chcolor(glut.bg);
        g.frect(off, isz);
        g.chcolor(glut.fg);
        g.frect(off, new Coord((int) Math.round(isz.x * (glut.glut - Math.floor(glut.glut))), isz.y));
        g.chcolor();
        g.image(bg, Coord.z);
        if (Config.showmetertext) {
            g.atextstroked(String.format("%.2f\u2030:%d%%", glut.lglut * 1000, Math.round(glut.gmod * 100)), sz.div(2).add(10, -1), 0.5, 0.5, Color.WHITE, Color.BLACK, Text.num10Fnd);
        }
        super.draw(g);
    }

    @Override
    public Object tooltip(Coord c, Widget prev) {
        return glut.tooltip(c, prev);
    }
}