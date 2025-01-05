function musl_build --description="Build a single binary through MUSL. This is also accounted for SQLX as a bonus."
    docker run \
        -v cargo-cache:/root/.cargo/registry \
        -v "$PWD:/volume" \
        -e SQLX_OFFLINE=true \
        --rm -it clux/muslrust sh -c "cargo build --release && chown -R $(id -u):$(id -g) ./target"
end