
## NOTE
The addons is required externally library, [TextEngine](https://github.com/ltibm/TextEngine/) 

## Installation
1. Download https://github.com/ltibm/TextEngine/ as zip and extract all files in the **scripts** folder
2. Download **all** files and copy to **scripts/plugins** folder.
3. Open your **default_plugins.txt** in **svencoop** folder
  and put in;
```
"plugin"
{
    "name" "Conditional Config Loader"
    "script" "lt_conditionalconfig"
    "concommandns" "lt"
}
```
4. Send command **as_reloadplugins** to server or restart server.
5. You can find config files in the **scripts/plugins/LtCndConfig/configs/** folder

## Commands
- usage **as_command lt.cconfig_status 1**
- **lt.cconfig_status**: 0 or 3, Enable or Disable current plugin (default 3), 0 disabled, 1: Load MapInit Triggered, 2: Load MapActivat Triggered, 3: Load MapStart triggered.
- **lt.cconfig_loadtime** Set conditional config file load time(default 0.25);


Try another lazy config file loader.