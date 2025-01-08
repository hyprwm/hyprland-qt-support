pragma Singleton
import QtQuick

HyprlandStyleBase {
    id: root

    function flat(color: color, flat: bool): color {
        return flat ? root.transparent(color) : color;
    }

    function isDark(cg: ColorGroup): bool {
        return cg.windowText.hsvValue > cg.window.hsvValue;
    }

    function lightenOrDarken(color: color, factor: real): color {
        return color.hsvValue > 0.5 ? Qt.darker(color, factor) : Qt.lighter(color, factor);
    }

    function overlay(base: color, tint: color, tintOpacity: real): color {
        return Qt.tint(base, Qt.alpha(tint, tintOpacity));
    }

    function scaledColor(cg: ColorGroup, index: int): color {
        switch (index * (root.isDark(cg) ? 1 : -1)) {
        case -2:
            return cg.light;
        case -1:
            return cg.midlight;
        case 1:
            return cg.mid;
        case 2:
            return cg.dark;
        }
    }

    // ColorAnimation animates all properties of a color, instead of mixing normally, so
    // transparency has to have the same RGB.
    function transparent(color: color): color {
        return Qt.alpha(color, 0.0);
    }
}
