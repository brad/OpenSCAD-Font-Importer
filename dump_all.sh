#!/bin/sh
# googlefontdirectory is a git submodule that needs to be initialized first.
# This script also requires stl2pov. Find it here: http://rsmith.home.xs4all.nl/software/py-stl-stl2pov.html
# And povray found in your friendly linux repository
mkdir -p fonts # make sure output directory exists
find ./googlefontdirectory/fonts/*.ttf | awk '{
  split($1, path, "/")
  split(path[4], fontname, ".")
  name = fontname[1]
  gsub(/\-/, "_", name)
  cmd = "python full_ddump.py -f \"" $1 "\" -o fonts/\"" name ".scad\" -m \"" name "\""
  system(cmd)

  # Uncomment this block to generate *_test.stl and test png files for all fonts. Will take about a day
  #system("echo \"include <fonts/" name ".scad>\n\" > " name "_test.scad")
  ##system("echo \"" name "(\\\"Grumpy wizards make toxic brew for the evil Queen and Jack.\\\");\" >> " name "_test.scad")
  #system("echo \"text = \\\"" name "\\\";\nwidth = " name "_width(text);\n" name "(text, center = true);\nlinear_extrude(height = 10)\ndifference() {\n\tsquare([width + 10, 0.75 * (width + 10)], center = true);\n\tsquare([width + 10 - 2, 0.75 * (width + 10 - 2)], center = true);\n}\" >> " name "_test.scad")
  #system("openscad -m make " name "_test.scad -o fonts/" name ".stl")
  #system("stl2pov fonts/" name ".stl > font.inc")
  #system("povray +Iscene.pov +Ofonts/" name ".png +D +W640 +H480 +A0.5")
  #system("rm font.inc")
  #system("rm " name "_test.scad")

  # Uncomment this block to generate view *.stl files for all fonts. Will take about a day
  #system("echo \"include <" name ".scad>\n\" > " name "_view.scad")
  #system("echo \"scale([0.65, 0.65, 0.65]) rotate([60, 0, -45]) " name "(\\\"" name "\\\", center=true);\" >> " name "_view.scad")
  #system("openscad -m make " name "_view.scad -o " name ".stl")
  #system("rm " name "_view.scad")
}'
