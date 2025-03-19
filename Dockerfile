#FROM postgres:15-bookworm
FROM postgres:14.15-bookworm

RUN \
	apt update -y && \
	apt install -y \
		curl tar

WORKDIR /app

COPY scripts/install-pg.sh .

RUN \
	bash install-pg.sh net && \
	bash install-pg.sh azure && \
	bash install-pg.sh azuread && \
    bash install-pg.sh microsoft365 && \
	bash install-pg.sh aws && \
	bash install-pg.sh gcp && \
    bash install-pg.sh cloudflare

CMD ["postgres"]
