sudo useradd -m danny
sudo passwd danny

sudo useradd -m koen
sudo passwd koen

sudo useradd -m david
sudo passwd david

conda activate myenvs
python -m ipykernel install --name "myenvs" --display-name "Python (myenvs)" --sys-prefix

#generate jupyter config
jupyterhub --generate-config

#update below line in config
c.Authenticator.allowed_users = {'danny', 'koen', 'david'}

#test jupyterhub

run command "jupyterhub" in myenvs

# Create  Jupyterhub service /etc/systemd/system/jupyterhub.service

[Unit]
Description=JupyterHub
After=network.target

[Service]
User=rheluser
Environment=PATH=/home/rheluser/miniforge/envs/myenvs/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
ExecStart=/home/rheluser/miniforge/envs/myenvs/bin/jupyterhub -f /home/rheluser/jupyterhub_config.py
Restart=on-failure

[Install]
WantedBy=multi-user.target


#restart Jupyterhub
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable jupyterhub
sudo systemctl start jupyterhub
sudo systemctl status jupyterhub


