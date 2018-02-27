h:
del "%localappdata%\Real Games\Factory IO\*.*" /Q /S
copy h:\TiaPortal_V14\Factory_IO\config.cfg "%localappdata%\Real Games\Factory IO\config.cfg"
cd h:\TiaPortal_V14\Foerderband
start h:\TiaPortal_V14\Factory_IO\Factory_IO_Foerderband.factoryio
start Foerderband.ap14
