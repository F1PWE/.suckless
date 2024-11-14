echo "cloning git repo"
git clone https://github.com/F1PWE/.suckless.git $HOME/.my_dwm
sleep .5
echo "extracting dot files to home."
cp -r $HOME/.my_dwm/dotfiles/* $HOME/
sleep .5
echo "source .profile"
source $HOME/.profile
sleep .5
echo "extracting dwm to home"
cp -r $HOME/.my_dwm/.suckless $HOME/
sleep .5
echo "compiling dwm"
for program in dwm st slstatus dmenu; do
	cd $HOME/.my_dwm/$program
	make PREFIX=$HOME/.local/ install
done
