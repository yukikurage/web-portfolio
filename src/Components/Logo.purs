module Components.Logo where

import Prelude

import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Hooks.UseInnerHTML (useInnerHTML)
import Jelly (Component, el)

logoComponent :: Component Contexts
logoComponent = el "div" do
  useClass $ pure "stroke-current h-full w-full fill-current"

  useInnerHTML $ pure
    "<svg width=\"100%\" height=\"100%\" viewBox=\"0 0 3.757 3.347\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns=\"http://www.w3.org/2000/svg\"><defs><clipPath clipPathUnits=\"userSpaceOnUse\" id=\"d\"><rect style=\"stroke-width:0;stroke-linecap:butt;stroke-dasharray:none;stroke-opacity:1\" width=\"2.121\" height=\"3.241\" x=\"1.062\" y=\"1.662\" ry=\"0\"/></clipPath><clipPath clipPathUnits=\"userSpaceOnUse\" id=\"c\"><rect style=\"stroke-width:0;stroke-linecap:butt;stroke-dasharray:none;stroke-opacity:1\" width=\"1.852\" height=\"2.381\" x=\"1.323\" y=\"1.852\" ry=\"0\"/></clipPath><pattern xlink:href=\"#a\" id=\"b\"/><pattern patternUnits=\"userSpaceOnUse\" width=\"5\" height=\"3\" patternTransform=\"translate(5 16)\" id=\"a\"><rect style=\"fill-opacity:1;stroke-width:0;stroke-linecap:butt;stroke-dasharray:none;stroke-opacity:1\" width=\"5\" height=\"3\" ry=\"0\"/></pattern></defs><path style=\"stroke-width:.105833;stroke-linecap:round;stroke-linejoin:round;stroke-dasharray:none;stroke-opacity:1\" d=\"M1.797 1.852 1.4 4.233h.886l.397-2.38z\" transform=\"translate(-1.347 -1.613)\"/><path style=\"stroke-width:.105833;stroke-linejoin:round;stroke-dasharray:none;stroke-opacity:1\" d=\"m1.907 1.662-.564 3.241h.888l.564-3.241z\" transform=\"translate(-.098 -1.609)\"/><path style=\"fill:none;stroke-width:.978958;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:3;stroke-dasharray:none;stroke-opacity:1\" d=\"M.782 2.279c.547-.503 1.42-1.049 1.91-.993 1.097.124.695 1.663-.42 1.51\" transform=\"translate(-.072 -.35)\"/></svg>"
