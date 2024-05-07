cd
mkdir venvs
cd venvs

# vdsql
mkdir vdsql
cd vdsql
mise shell python@3.11
python -m venv .venv
source .venv/bin/activate
cd ~/github/saulpw/visidata/visidata/apps/vdsql/
pip install .
cd ~/github/saulpw/visidata
pip install .
pip install 'ibis-framework[duckdb]'
