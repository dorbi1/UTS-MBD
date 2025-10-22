# UTS: PostgreSQL + PGAdmin (Docker) — Marip Ramadhan (NIM 1237050128)

- PostgreSQL: 22128 (host) → 5432 (container)
- PGAdmin4 : 44128 (host) →   80 (container)


```bash
cp .env.example .env
docker compose up -d
```
PGAdmin: buka http://localhost:44128 
Tambah server:
- Host: `postgres_Marip_Ramadhan` 
- Port: 5432
- DB: postgres
- User: postgres
- Pass: ifunggul
```

## Schema
- `SALAM.mahasiswas` dengan PK, UNIQUE (nim,email), CHECK (format nim 10 digit, ipk 0..4, angkatan 2018..2030)

## Roles
- `backend_dev` → CRUD semua table
- `bi_dev` → SELECT-only semua table/view
- `data_engineer` → CREATE/MODIFY/DROP objects + CRUD
