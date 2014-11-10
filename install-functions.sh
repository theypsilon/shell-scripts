# debian package version

exists_package() {
    if dpkg -s $1 > /dev/null 2>&1 ; then
        return 0
    else
        return 1
    fi
}

install_package() {
    if ! exists_package $1 ; then
        sudo apt-get -y install $1
    fi
}

add_repository() {
    sudo apt-add-repository -y $1
    sudo apt-get update
}

install_external_package() {
	wget $1 && sudo dpkg -i -
}