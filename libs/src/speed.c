#include "speed.h"

int
c_get_speed (lua_State *l)
{
    const char * ifa = lua_tostring(l, -1);
        
    struct rtnl_link *link;
    struct nl_sock *socket;
    int upload, download;

    socket = nl_socket_alloc ();
    nl_connect (socket, NETLINK_ROUTE);

    if (rtnl_link_get_kernel (socket, 0, ifa, &link) >= 0)
        {
            download = rtnl_link_get_stat (link, RTNL_LINK_RX_BYTES);
            upload = rtnl_link_get_stat (link, RTNL_LINK_TX_BYTES);
            rtnl_link_put (link);
        }

    lua_newtable(l);
    lua_pushinteger(l, download);
    lua_setfield(l, -2, "download");

    lua_pushinteger(l, upload);
    lua_setfield(l, -2, "upload");

    nl_socket_free (socket);
    return 1;
}
