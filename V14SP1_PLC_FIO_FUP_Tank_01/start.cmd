h:
del "%localappdata%\Real Games\Factory IO\*.*" /Q /S
copy h:\TiaPortal_V14\Factory_IO\config.cfg "%localappdata%\Real Games\Factory IO\config.cfg"
cd h:\TiaPortal_V14\Tank
start h:\TiaPortal_V14\Factory_IO\Tank.factoryio
start Tank.ap14
