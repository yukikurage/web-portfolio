module Components.Logo where

import Prelude

import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Hooks.UseInnerHTML (useInnerHTML)
import Jelly (Component, el)

logoComponent :: Component Contexts
logoComponent = el "div" do
  useClass $ pure "stroke-current h-full w-full"

  useInnerHTML $ pure
    "<svg width=\"100%\" height=\"100%\" viewBox=\"0 0 3.75 3.24\" inkscape:version=\"1.2.1 (9c6d41e410, 2022-07-14)\" sodipodi:docname=\"yu_logo.svg\" xmlns:inkscape=\"http://www.inkscape.org/namespaces/inkscape\" xmlns:sodipodi=\"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns=\"http://www.w3.org/2000/svg\"><sodipodi:namedview pagecolor=\"#ffffff\" bordercolor=\"#000000\" borderopacity=\".25\" inkscape:showpageshadow=\"true\" inkscape:pageopacity=\"0\" inkscape:pagecheckerboard=\"true\" inkscape:deskcolor=\"#d1d1d1\" inkscape:document-units=\"mm\" showgrid=\"true\" showborder=\"true\" borderlayer=\"true\" shape-rendering=\"auto\" inkscape:zoom=\"11.314\" inkscape:cx=\"-10.12\" inkscape:cy=\"29.919\" inkscape:window-width=\"1409\" inkscape:window-height=\"1230\" inkscape:window-x=\"1068\" inkscape:window-y=\"599\" inkscape:window-maximized=\"0\" inkscape:current-layer=\"layer1\"><inkscape:grid type=\"xygrid\" originx=\"-.095\" originy=\"-.403\"/></sodipodi:namedview><defs><pattern inkscape:collect=\"always\" xlink:href=\"#a\" id=\"b\"/><pattern patternUnits=\"userSpaceOnUse\" width=\"5\" height=\"3\" patternTransform=\"translate(5 16)\" id=\"a\"><rect width=\"5\" height=\"3\" ry=\"0\" stroke-width=\"0\"/></pattern><clipPath id=\"d\"><rect width=\"2.121\" height=\"3.241\" x=\"1.06\" y=\"1.66\" ry=\"0\" stroke-width=\"0\"/></clipPath><clipPath id=\"c\"><rect width=\"1.852\" height=\"2.381\" x=\"1.32\" y=\"1.85\" ry=\"0\" stroke-width=\"0\"/></clipPath></defs><g inkscape:label=\"Layer 1\" inkscape:groupmode=\"layer\" stroke-width=\".979\"><path d=\"M2.38 1.32L1.85 4.5\" clip-path=\"url(#c)\" inkscape:label=\"path1742\" transform=\"translate(-1.37 -1.666)\"/><path d=\"M2.65.26L1.59 6.35\" clip-path=\"url(#d)\" inkscape:label=\"path1742\" sodipodi:nodetypes=\"cc\" transform=\"translate(-.12 -1.662)\"/><path d=\"M.69 1.88c.55-.5 1.42-1.05 1.92-1 1.09.13.69 1.67-.43 1.52\" sodipodi:nodetypes=\"ccc\" inkscape:label=\"path5496\" fill=\"none\" stroke-miterlimit=\"3\"/></g></svg>"
