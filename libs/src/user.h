#pragma once

#include <pwd.h>
#include <security/pam_appl.h>
#include <security/pam_misc.h>
#include <string.h>
#include <unistd.h>

#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>

int get_username (lua_State *l);

int auth_current_user (lua_State *l);
