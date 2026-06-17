import os, json, pathlib, urllib.request, sys

SUPABASE_URL = "https://jmqwxbfllvaizuydpeim.supabase.co"
SUPABASE_KEY = "sb_publishable_3ATrJc5dTkijTW-iSRL5Qw_7l1-NIj1"

def upsert(table, rows):
    url = f"{SUPABASE_URL}/rest/v1/{table}"
    req = urllib.request.Request(
        url,
        data=json.dumps(rows).encode(),
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
            print(f"OK {table}: {resp.status}")
    except urllib.error.HTTPError as e:
        print(f"Erro {e.code}: {e.read().decode()}")
        sys.exit(1)

# Load data from data-sync.json
data = json.loads(pathlib.Path("data-sync.json").read_text())
for table, rows in data.items():
    if rows:
        upsert(table, rows)
        print(f"Inseridos {len(rows)} registro(s) em {table}")

print("Sincronizacao concluida!")
