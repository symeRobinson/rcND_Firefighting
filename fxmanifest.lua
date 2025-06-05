fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'rcND'
description 'Firefighting configuration menu'

-- NativeUILua is required as an external dependency
client_scripts {
    '@NativeUI/NativeUI.lua',
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

files {
    'data/stations.json'
}

