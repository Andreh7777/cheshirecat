import asyncio
import json
import os
from typing import List

from cat.mad_hatter.mad_hatter import MadHatter
from cat.mad_hatter.registry import registry_download_plugin, registry_search_plugins

__PLUGIN_FILE="/app/seeweb_plugins.json"

mad_hatter = MadHatter()

def __get_plugins_list() -> List[str]:
    if not os.path.exists(__PLUGIN_FILE):
        raise FileNotFoundError(f"{__PLUGIN_FILE} does not exist.")

    with open(__PLUGIN_FILE, "r") as f:
        return json.load(f)

async def install_seeweb_plugins():
    plugin_list = __get_plugins_list()
    print(f"Installing {len(plugin_list)} plugins...")
    for plugin in plugin_list:
        print(f"Installing {plugin}...")
        for attempt in range(3): #max 3 tentativi
            try:
                plugin_path = await registry_download_plugin(plugin)
                mad_hatter.install_plugin(plugin_path)
                break
            except Exception as e:
                print(f"Failed to install {plugin} (attempt {attempt + 1}/3) : {e}")
                if attempt == 2:
                    raise
                await asyncio.sleep(5)
    print("All plugins installed.")

asyncio.run(install_seeweb_plugins())



