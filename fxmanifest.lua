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
    'main.lua'
}

shared_scripts {
    'config.lua'
}

server_scripts {
    'event.lua'
}

dependencies {
    "PolyZone"
}
