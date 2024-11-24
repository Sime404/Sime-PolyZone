fx_version 'cerulean'

games { 'gta5' }

dependencies {
    'PolyZone'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@PolyZone/EntityZone.lua',
    'client/main.lua'
}

shared_scripts {
    'shared/config.lua'
}

server_scripts {
    'server/event.lua'
}

dependencies {
    "PolyZone"
}