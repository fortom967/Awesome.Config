#include "speed.h"
#include "wifi.h"

const struct luaL_Reg funcs[]
    = { { "c_get_speed", c_get_speed }, { NULL, NULL } };

int
luaopen_libs_lib (lua_State *l)
{
    lua_newtable (l);
    luaL_setfuncs (l, funcs, 0);

    return 1;
}
