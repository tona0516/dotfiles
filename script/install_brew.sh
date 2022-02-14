check_prerequisite() {
    if [ `uname` != "Darwin" ]; then
        echo "[ERROR] must be MacOS"
        exit 1
    fi
}

install_brew_if_needed() {
    homebrew_path="/opt/homebrew"
    if [ `uname -m` = "arm64" ] && !(type $homebrew_path"/bin/brew" > /dev/null 2>&1); then
        echo "[INFO] install brew as arm64"
        sudo mkdir $homebrew_path
        sudo chown $USER:admin $homebrew_path
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $homebrew_path
        PATH=/opt/homebrew/bin/:$PATH
    fi

    if [ `uname -m` = "x86_64" ] && !(type brew > /dev/null 2>&1); then
        echo "[INFO] install brew as x86_64"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "[INFO] brew command path - "`which brew`
}

install_package_if_needed() {
    if brew list --full-name | grep $1 > /dev/null 2>&1; then
        echo "[INFO] "$1" is already installed. skip process."
        return 1
    fi
    brew install $1
}

install_brew_if_needed

packages=(
    node
    tree
    wget
    jq
    shiftit
    iterm2
    visual-studio-code
    android-studio
    alfred
    google-japanese-ime
    gas-mask
    zoom
    rbenv
    ruby-build
    automake
    stern
    swiftlint
    kubectx
    kubectl
    jazzy
    graphviz
    fastlane
    cloudfoundry/tap/cf-cli
    anydesk
    cocoapods
    carthage
)
for package in ${packages[@]}
do
    install_package_if_needed $package
done
