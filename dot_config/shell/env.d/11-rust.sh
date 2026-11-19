# Rust environment.
: "${RUSTUP_HOME:=$HOME/.rustup}"
: "${CARGO_HOME:=$HOME/.cargo}"
export RUSTUP_HOME CARGO_HOME

case ":$PATH:" in
    *":$CARGO_HOME/bin:"*) ;;
    *) PATH="$CARGO_HOME/bin:$PATH" ;;
esac
export PATH

check_tool cargo
