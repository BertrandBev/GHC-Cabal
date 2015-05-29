 DEF=`pwd`

 echo "#################"
 echo "# GHC Installer #"
 echo "#################"
 echo ""
 echo 
 
 read -e -p "Installation dir (default : $DEF) ? " DIR
 DIR=${DIR:-$DEF}
 echo $DIR 

 echo "Available GHC versions"
 PS3='Install which version ? '
 select VER in '7.10.1' '7.8.4' '7.8.3' '7.8.2' '7.8.1' '7.6.3' '7.6.2' '7.6.1' '7.4.2' '7.4.1' '7.2.2' '7.2.1' '7.0.4' '7.0.3' '7.0.2' '7.0.1' '6.12.3' '6.12.2' '6.12.1' '6.10.4' '6.10.3' '6.10.2' '6.10.1' '6.8.3' '6.8.2' '6.8.1' '6.6.1'
 do 
 echo "Installing GHC $VER"
 break
 done

 CLN=${VER//.}
 RAW=${CLN:0:2}

 if [ $RAW -eq 71 -o $RAW -eq 78 ]; then 
  ADDR="ghc-$VER-x86_64-unknown-linux-deb7.tar.bz2"
 else 
  ADDR="ghc-$VER-x86_64-unknown-linux.tar.bz2"
 fi

 if [ ! -d "$DIR/ghc-$VER" ]; then

 echo "Downloading GHC v$VER"

# get distr  
 cd $HOME/Downloads  
# 64 bit
 wget https://www.haskell.org/ghc/dist/$VER/$ADDR   
 tar xvfj $ADDR  

 if [ ! -d "$HOME/Downloads/ghc-$VER" ]; then
  echo "Error : The version required doesn't exist"
  exit 1
 fi
  
 cd ghc-$VER  

# install to  
 mkdir $DIR/ghc-$VER

 ./configure --prefix=$DIR/ghc-$VER  

 make install

# remove temporary files  
 cd $HOME/Downloads  
 rm -rfv ghc-$VER*

 else
 echo "The requested GHC version already exists"
 fi

# symbol links  
 cd $DIR
 rm -f ghc
 ln -s `pwd`/ghc-$VER ghc  

# add ghc to $PATH  
 GHC_HOME=$DIR/ghc/bin  

 case ":${PATH:=$GHC_HOME}:" in
    *:$GHC_HOME:*)  ;;
    *) echo "export PATH=$GHC_HOME:\$PATH" >> $HOME/.bashrc ;;
 esac

 if [ -f $GHC_HOME/ghc ]; then
  echo "GHC successfully installed!"
  $GHC_HOME/ghc --version
 else
  echo "Installation error!"
 fi

# to use updated path without log off

 bash
