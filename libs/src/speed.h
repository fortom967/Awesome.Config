#pragma once

#include <inttypes.h>
#include <stdio.h>
#include <unistd.h>

#include <netlink/cache.h>
#include <netlink/netlink.h>
#include <netlink/route/link.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int c_get_speed(lua_State * l);
