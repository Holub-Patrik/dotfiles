# this should install all packages to do most stuff
# most don't need explanation, except binextra
# that's where latexmk is located

sudo pacman -S \
	texlive-basic \
	texlive-latex \
	texlive-latexrecommended \
	texlive-latexextra \
	texlive-fontsrecommended \
	texlive-bibtexextra \
	texlive-mathscience \
	texlive-langczechslovak \
	texlive-binextra

sudo pacman -S zathura zathura-pdf-mupdf
# for svgs
sudo pacman -S inkscape 
cargo install tex-fmt
