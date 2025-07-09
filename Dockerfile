#FROM ghcr.io/cheshire-cat-ai/core:latest
#
#RUN pip install --upgrade pip setuptools wheel typing_extensions && \
#RUN  pip install --no-cache-dir .
#
#COPY ./install_seeweb_plugins.py /app/install_seeweb_plugins.py
#COPY ./seeweb_plugins.json /app/seeweb_plugins.json
#
#RUN python3 ./install_seeweb_plugins.py
#RUN python3 ./install_plugin_dependencies.py
#
#COPY ./default_metadata.json /app/cat/data/metadata.json
#
#CMD ["python3", "-m", "cat.main"]
#

FROM ghcr.io/cheshire-cat-ai/core:latest

# Installa tool base + versioni compatibili
RUN pip install --upgrade pip setuptools wheel \
    && pip install typing_extensions==4.14.1 \
    && pip install sentence-transformers==4.1.0 \
    && pip install unstructured==0.18.1

# Installa il tuo pacchetto (usa il pip locale solo dopo)
COPY . /app
WORKDIR /app
RUN pip install --no-cache-dir .

# Copia e installa plugin seeweb
COPY ./install_seeweb_plugins.py /app/install_seeweb_plugins.py
COPY ./seeweb_plugins.json /app/seeweb_plugins.json
RUN python3 ./install_seeweb_plugins.py

# Dipendenze dei plugin installati
RUN python3 ./install_plugin_dependencies.py

# Metadata
COPY ./default_metadata.json /app/cat/data/metadata.json

CMD ["python3", "-m", "cat.main"]
