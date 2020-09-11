# Copyright (C) 2019-2020 Donald Isaac
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# If pdflatex isn't installed, check if the latex docker container command
# exists in the path.
# TODO: Support more LaTeX compilers
ifneq (, $(shell which pdflatex))
CC=pdflatex
FLAGS=""
else ifneq (, $(shell which latexmk))
CC=latexmk
FLAGS="-pdf"
else ifneq (, $(shell which latexdockercmd.sh))
CC="latexdockercmd.sh"
FLAGS="pdflatex"
else
$(error "No LaTeX compiler in path, consider doing 'apt-get install pdflatex'")
endif

# Determine which executable to use to open the PDF.
ifneq (, $(shell which chrome))
BROWSER=chrome
else ifneq (, $(shell which firefox))
BROWSER=firefox
else ifneq (, $(shell which xdg-open))
BROWSER=xdg-open
else
BROWSER=open
endif

.PHONY: open

sheet.pdf: sheet.tex
	$(CC) $(FLAGS) sheet

open: sheet.pdf
	$(BROWSER) sheet.pdf