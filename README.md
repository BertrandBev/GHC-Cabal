# GHC-Cabal
Scripts to install GHC and Cabal

To install seamlessly the desired versions, and to switch between them, you can use these two homebrew scripts. The first one is for GHC from v 6.6.1 to v 7.10.1, and features a package detection system to avoid the hefty download and de-package process if the required version has already been installed previously. The second one installs Cabal and Cabal-install, from v 1.18.0 to v 1.22.3.0, in the standard installation directory ($HOME/.cabal). Note that the latter requires a suited version of GHC, then make sure to run them in the right order. 


You might need to install the following libraries to have ghc and cabal work :

sudo apt-get install -y libgmp-dev curl zlib1g-dev libgmp3-dev freeglut3 freeglut3-dev libreadline6

And create the following simlink for old versions of ghc :

sudo ln -s /usr/lib/x86_64-linux-gnu/libgmp.so.10 /usr/lib/libgmp.so.3
