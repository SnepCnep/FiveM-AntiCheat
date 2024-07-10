fx_version 'cerulean'
game 'gta5'

author 'SnepCnep'
description 'AntiCheat resource for FiveM'
version '0.0.1'
lua54 'yes'

client_scripts {
    'src/client/main.lua',
    'src/modules/**/client.lua',
}

server_scripts {
    'config.lua',
    'src/server/main.lua',
    'src/server/installer.lua',
    'src/modules/**/server.lua',
}

files {
    'init.lua'
}