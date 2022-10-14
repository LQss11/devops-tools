apt-get update 
apt-get install -y python3-pip 
apt-get install -y python3-venv
python3 -m venv ~/virtualenvs/remote_state
. ~/virtualenvs/remote_state/bin/activate
pip install -U -r requirements.txt
python stateserver.py
