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
    "<svg width=\"100%\" height=\"100%\" viewBox=\"0 0 3.692 3.241\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns=\"http://www.w3.org/2000/svg\"><defs><clipPath clipPathUnits=\"userSpaceOnUse\" id=\"d\"><rect width=\"2.121\" height=\"3.241\" x=\"1.062\" y=\"1.662\" ry=\"0\" stroke-width=\"0\"/></clipPath><clipPath clipPathUnits=\"userSpaceOnUse\" id=\"c\"><rect width=\"1.852\" height=\"2.381\" x=\"1.323\" y=\"1.852\" ry=\"0\" stroke-width=\"0\"/></clipPath><pattern xlink:href=\"#a\" id=\"b\"/><pattern patternUnits=\"userSpaceOnUse\" width=\"5\" height=\"3\" patternTransform=\"translate(5 16)\" id=\"a\"><rect width=\"5\" height=\"3\" ry=\"0\" stroke-width=\"0\"/></pattern></defs><g stroke-width=\".979\"><path d=\"M2.381 1.323l-.529 3.175\" clip-path=\"url(#c)\" transform=\"translate(-1.37 -1.666)\"/><path d=\"M2.646.265L1.588 6.35\" clip-path=\"url(#d)\" transform=\"translate(-.12 -1.662)\"/><path d=\"M.688 1.875C1.234 1.373 2.318.746 2.65.792c.947.13.6 1.7-.49 1.734\" fill=\"none\" stroke-miterlimit=\"3\"/></g></svg>"
