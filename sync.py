import os, json, pathlib, urllib.request, sys

ref   = os.environ["PROJ_REF"]
token = os.environ["MGMT_TOKEN"]
sql   = pathlib.Path("data-sync.sql").read_text()

url = f"https://api.supabase.com/v1/projects/{ref}/database/query"
req = urllib.request.Request(
    url,
    data=json.dumps({"query": sql}).encode(),
    headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
    method="POST"
)
try:
    with urllib.request.urlopen(req) as resp:
        result = json.loads(resp.read())
        print("Sucesso:", result)
except urllib.error.HTTPError as e:
    body = e.read().decode()
    print("Erro HTTP", e.code, ":", body)
    sys.exit(1)
