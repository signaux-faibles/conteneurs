# ── Stage 1 : compilation ─────────────────────────────────────────
FROM postgres:17 AS builder

RUN apt-get update && apt-get install -y \
    git curl clang libclang-dev llvm make gcc \
    libssl-dev pkg-config postgresql-server-dev-17 \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

ENV CARGO_PGRX_VERSION=0.16.1
RUN cargo install --force --locked cargo-pgrx@"${CARGO_PGRX_VERSION}"
RUN cargo pgrx init --pg17 $(which pg_config)

RUN git clone --depth 1 https://github.com/CrunchyData/pg_parquet.git /pg_parquet
WORKDIR /pg_parquet
RUN cargo pgrx install --release --features pg17

# ── Stage 2 : image finale Debian ─────────────────────────────────
FROM postgres:17

COPY --from=builder /usr/lib/postgresql/17/lib/pg_parquet.so /usr/lib/postgresql/17/lib/
COPY --from=builder /usr/share/postgresql/17/extension/pg_parquet* /usr/share/postgresql/17/extension/

RUN echo "shared_preload_libraries = 'pg_parquet'" >> /usr/share/postgresql/postgresql.conf.sample
