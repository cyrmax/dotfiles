# Go environment.
: "${GOPATH:=$HOME/go}"
export GOPATH

case ":$PATH:" in
    *":$GOPATH/bin:"*) ;;
    *) PATH="$GOPATH/bin:$PATH" ;;
esac
export PATH

check_tool go
