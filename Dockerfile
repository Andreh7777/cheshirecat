FROM ghcr.io/cheshire-cat-ai/core:latest

ENV CHESHIRECAT_USERNAME=admin
ENV CHESHIRECAT_PASSWORD=admin

RUN  pip install --no-cache-dir .

COPY ./install_seeweb_plugins.py /app/install_seeweb_plugins.py
COPY ./initialize_users.py /app/initialize_users.py
COPY ./seeweb_plugins.json /app/seeweb_plugins.json

RUN python3 ./install_seeweb_plugins.py
RUN python3 ./install_plugin_dependencies.py

COPY ./default_metadata.json /app/cat/data/metadata.json

### FINISH ###
COPY ./start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]



