#
# This makefile can be used to convert Markdown formatted files to plain text.
#
# Usage:
#
# 1. Have this file available under your project tree,
#    e.g. submodules/mdwn2text/mdwn2text.mk
#
# 2. Include this file in your main Makefile, e.g.
#
#    include submodules/mdwn2text/mdwn2text.mk
#
# 3. Define MDWN_FILES variable in your main Makefile. These Markdown files
#    will be converted to text files replacing the .mdwn extension with
#    the extension specified in TEXT_EXTENSION variable (.txt by default,
#    can be overridden). Example:
#
#    MDWN_FILES = README.mdwn
#
# See below for the variable definitions.
#
# markdown.lua by Niklas Frykholm, <niklas@frykholm.se>,
# available at http://www.frykholm.se/files/markdown.lua,
# is required.
#
# Lynx in default path is required.
#
# Copyright: © 2011 Tuomas Jormola <tj@solitudo.net> http://solitudo.net
#
# Licensed under the terms of the GNU General Public License Version 2.0.
# License terms are included in the file `COPYING`.
#

# Location of markdown.lua
MDWN2TEXT		?= submodules/mdwn2text
MARKDOWN_LUA	?= $(MDWN2TEXT)/markdown.lua

# Command to run the Lua intrepeter
LUA				?= lua

# This command reads Markdown from stdin and prints (X)HTML to stdout
MDWN_TO_HTML	?= $(LUA) $(MARKDOWN_LUA)

# This command reads (X)HTML from stdin and prints text to stdout
HTML_TO_TEXT	?= lynx -stdin -dump

MDWN_EXTENSION	?= .mdwn
TEXT_EXTENSION	?= .txt
TEXT_FILES		?= $(MDWN_FILES:$(MDWN_EXTENSION)=$(TEXT_EXTENSION))

mdwn2text: $(TEXT_FILES)

%$(TEXT_EXTENSION): %$(MDWN_EXTENSION)
	$(MDWN_TO_HTML) < $< | $(HTML_TO_TEXT) > $@
