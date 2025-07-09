local all_parsers = require('parsers')
local lang = arg[1]
print(all_parsers[lang]['install_info']['url'])
print(all_parsers[lang]['install_info']['revision'])
