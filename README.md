# qlik-sense Cookbook

Basic cookbook to deploy a central node Qlik Sense server.

## Requirements

1. Qlik-Cli downloaded and imported into Powershell modules
2. Qlik Sense Enterprise downloaded into c:\apps folder
3. sp_config.xml file edited to ensure the shared persistence installation is correct (stored in c:\apps)


### Platforms

- Windows

### Chef

- Chef 12.0 or later

### Cookbooks

- Qlik-Sense

### Usage
Edit the recipe with your details.

Include `qlik-sense` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[qlik-sense]"
  ]
}
```
## License and Authors

Apache 2.0
