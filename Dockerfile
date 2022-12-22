FROM jupyterhub/jupyterhub

RUN apt update

RUN apt-get install npm nodejs python3 python3-pip git -y

RUN python3 -m pip install jupyterhub notebook jupyterlab

WORKDIR /home

RUN apt-get install git

RUN git clone https://github.com/jupyterhub/nativeauthenticator.git

WORKDIR nativeauthenticator

RUN python3 -m pip install --upgrade pip

RUN pip3 install -e .

WORKDIR /home

COPY /NOTEBOOKS_FROM /home/NOTEBOOKS

RUN mkdir /etc/jupyterhub

WORKDIR /etc/jupyterhub

RUN jupyterhub --generate-config -f jupyterhub_config.py

COPY Dockerfile .

COPY jupyterhub_config.py .

EXPOSE 8000

ENTRYPOINT [ "jupyterhub" ]

CMD jupyterhub -f jupyterhub_config.py
