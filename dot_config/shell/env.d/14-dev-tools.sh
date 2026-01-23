if command -v vcpkg &> /dev/null; then
    export VCPKG_DISABLE_METRICS=1
    export VCPKG_ROOT="$HOME/vcpkg"
    export PATH="$VCPKG_ROOT:$PATH"
fi
export ANSIBLE_INVENTORY="$HOME/infraconf/ansible/inventory.ini"
