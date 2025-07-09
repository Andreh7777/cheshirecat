FROM ghcr.io/cheshire-cat-ai/core:latest

#RUN pip install --upgrade pip setuptools wheel typing_extensions && \
RUN pip install --no-cache-dir .

COPY ./install_seeweb_plugins.py /app/install_seeweb_plugins.py
COPY ./seeweb_plugins.json /app/seeweb_plugins.json

RUN python3 ./install_seeweb_plugins.py
RUN python3 ./install_plugin_dependencies.py

COPY ./default_metadata.json /app/cat/data/metadata.json

CMD ["python3", "-m", "cat.main"]
