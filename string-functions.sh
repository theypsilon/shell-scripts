tolower() {
    echo "$(echo $1 | tr '[A-Z]' '[a-z]')"
}

toupper() {
    echo "$(echo $1 | tr '[a-z]' '[A-Z]')"
}