# empty docs/ folder
rm -rf docs/cv_ita.pdf docs/cv.pdf

# render the project
quarto render

#=========================================== (Push to Github repo) ================================================#
# check status
git status

# Add changes to git Index.
git add -A # ALL
git add -u # tracked
git add images/*

git commit -m " rivisto cv_long_ita.qmd"
		# git commit -m "revision INSTALL + cleanup slides 2"  -m "01_... + 00_carico_tab-contesto.qmd "

# Push local source (master branch) to remote reference (origin)
#cd .
git push origin master


#=========================================== tutto insieme  ================================================#
git add -u && git commit  -m "small correct" && git push origin master

#=========================================== COPIO FILE SU WEBSITE DIR  ================================================#
#!/bin/zsh

# NB Absolute paths begin with / !!!!!!
# Source directory (where the .pdf is located)
SOURCE_DIR="/Users/luisamimmi/Github/cv_typst/docs"

# Destination directory (where the .pdf will be copied to)
DEST_DIR="/Users/luisamimmi/Github/luisamimmi/cv"

# File name to copy
FILE_NAME="cv.pdf"

# Copy the file
cp "$SOURCE_DIR/$FILE_NAME" "$DEST_DIR/"

# List the files in the destination directory
# ls -l "$DEST_DIR" | grep ".pdf"
# ls -l "$DEST_DIR" | grep ".pdf" | awk '{print $6, $7, $8, $9}'
		# `ls -l` lists the files in long format (including last modification)
		# `awk '{print $6, $7, $8, $9}` extracts the mod date and time ($6, $7, $8 )
		# and the file name ($9)

ls -l "$DEST_DIR" | grep ".pdf" | awk -v dir="$DEST_DIR" '{print dir, "->",  $9 " (last saved on", $6, $7, $8, ")"}'

#=========================================== Tracked by mistake in git   ================================================#
git rm --cached _freeze/cv/execute-results/typ.json
