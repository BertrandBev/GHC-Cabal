 DEF=`pwd`

 echo "###################"
 echo "# Cabal Installer #"
 echo "#  GHC required   #"
 echo "###################"
 echo ""
 
 echo "Available Cabal versions"
 PS3='Install which version ? '
 select VER in '1.22.3.0' '1.22.2.0' '1.22.0.0' '1.20.0.3' '1.20.0.2' '1.20.0.1' '1.20.0.0' '1.18.1.6' '1.18.1.5' '1.18.1.4' '1.18.1.3' '1.18.1.2' '1.18.1.1' '1.18.1' '1.18.0'
 do 
 echo "Installing Cabal $VER"
 break
 done

 ADDR="https://www.haskell.org/cabal/release/cabal-$VER/Cabal-$VER.tar.gz"

 echo "Downloading Cabal v$VER"

# clone dist  
 cd $HOME/Downloads  
 curl -O $ADDR

# extract   
 tar xzvf Cabal-$VER.tar.gz  
 cd Cabal-$VER  

 if [ ! -d "$HOME/Downloads/Cabal-$VER" ]; then
  echo "Error : The version required doesn't exist"
  exit 1
 fi

# remove old  
 rm -rfv $HOME/.cabal
 rm -rfv $HOME/.ghc

# build
 ghc --make Setup.hs
 ./Setup configure --user
 ./Setup build
 ./Setup install

# Remove temporary files
 cd $HOME/Downloads
 rm -rfv Cabal-$VER*

###################
# Cabal -- install
###################

 CLN=${VER//.}
 RAW=${CLN:0:3}
 if [ $RAW -eq 118 ]; then
   VER='1.18.1.0'
 fi
 
# get distributive  
 cd $HOME/Downloads  
 curl -O https://www.haskell.org/cabal/release/cabal-install-$VER/cabal-install-$VER.tar.gz

# extract archive  
 tar xzvf cabal-install-$VER.tar.gz  
 cd cabal-install-$VER  

# install  
 chmod 777 ./bootstrap.sh
 ./bootstrap.sh

# remove temporary files  
 cd $HOME/Downloads  
 rm -rfv cabal-install-$VER *  

# add path to cabal to PATH environment
 CABAL_HOME=$HOME/.cabal/bin 

 case ":${PATH:=$CABAL_HOME}:" in
    *:$CABAL_HOME:*)  ;;
    *) echo "export PATH=$CABAL_HOME:\$PATH" >> $HOME/.bashrc ;;
 esac
 
 cd $DEF

 if [ -f $HOME/.cabal/bin/cabal ]; then
  echo "Cabal successfully installed!"
  $HOME/.cabal/bin/cabal --version
 else
  echo "Installation error!"
 fi

 bash
