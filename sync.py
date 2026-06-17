import os, json, pathlib, urllib.request, sys, urllib.error

SUPABASE_URL = "https://jmqwxbfllvaizuydpeim.supabase.co"
SUPABASE_KEY = "sb_publishable_3ATrJc5dTkijTW-iSRL5Qw_7l1-NIj1"

def clean(rows):
    """Remove None/null values so Supabase doesn't complain about missing columns."""
    return [{k: v for k, v in row.items() if v is not None} for row in rows]

def upsert(table, rows):
    rows = clean(rows)
    url = f"{SUPABASE_URL}/rest/v1/{table}"
    req = urllib.request.Request(
        url,
        data=json.dumps(rows).encode("utf-8"),
        headers={
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json",
            "Prefer": "resolution=merge-duplicates,return=minimal"
        },
        method="POST"
    )
    try:
        with urllib.request.urlopen(req) as resp:
            print(f"OK {table}: status {resp.status}, {len(rows)} registro(s)")
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8")
        print(f"ERRO {e.code} em {table}: {body}")
        sys.exit(1)
    except Exception as ex:
        print(f"ERRO em {table}: {ex}")
        sys.exit(1)

data = json.loads(pathlib.Path("data-sync.json").read_text(encoding="utf-8"))
for table, rows in data.items():
    if rows:
        upsert(table, rows)

print("Sincronizacao concluida!")
