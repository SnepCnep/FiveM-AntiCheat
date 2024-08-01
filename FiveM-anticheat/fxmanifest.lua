fx_version 'cerulean'
game 'gta5'

author 'SnepCnep'
description 'AntiCheat resource for FiveM. (SnepCnep)'
version '1.0.0-Betá-4'
lua54 'yes'

client_scripts {
    'config.lua',
    'src/client/main.lua',
    'src/modules/**/client.lua',
}

server_scripts {
    'config.lua',
    'config.protect.lua',
    'src/server/main.lua',
    'src/server/banHandler.lua',
    'src/server/updater.lua',
    'src/server/installer.lua',
    'src/modules/**/server.lua',
}

ui_page 'src/web/ui.html'

files {
    'init.lua',
    'src/web/ui.html',
    'src/web/script.js',
    'license' -- if someone dumpt this, they will see the license :)
}