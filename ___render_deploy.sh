#=========================================== (Push to Github repo) ================================================#
# check status
git status

# Add changes to git Index.
git add -A # ALL
git add -u # tracked

git add docs/*
git add images/*
git add tools/*
    git add   _quarto.yml
    git add     r/00_useful.qmd
=======

git commit -m "cv.qmd"
git commit -m "worked r/02_r_vscode.qmd 😵‍💫"
		# git commit -m "revision INSTALL + cleanup slides 2"  -m "01_... + 00_carico_tab-contesto.qmd "

# Push local source (master branch) to remote reference (origin)
#cd .
git push origin master

#=========================================== tutto insieme  ================================================#
git add -u && git commit -a -m "added Shell/*" && git push

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
echo "Files in $DEST_DIR:"
ls "$DEST_DIR"
