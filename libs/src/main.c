#include "speed.h"
#include "user.h"
#include "wifi.h"

const struct luaL_Reg funcs[] = { { "c_get_speed", c_get_speed },
                                  { "get_username", get_username },
                                  { "authenticate", auth_current_user },
                                  { NULL, NULL } };

int
luaopen_libs_lib (lua_State *l)
{
    lua_newtable (l);
    luaL_setfuncs (l, funcs, 0);

    return 1;
}

int
luaopen_lib (lua_State *l)
{
    return luaopen_libs_lib (l);
}
