#pragma once

#include <glib-2.0/glib.h>
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>

#define IWD_BUS "net.connman.iwd"
#define IWD_PATH "/net/connman/iwd"
#define IWD_AGENT "net.connman.iwd.AgentManager"
#define IWD_NETWORK "net.connman.iwd.Network"
#define IWD_STATION "net.connman.iwd.Station"

int connect_to_network (lua_State *l);

int scan_for_networks (lua_State *l);

int disconnect_from_network (lua_State *l);
