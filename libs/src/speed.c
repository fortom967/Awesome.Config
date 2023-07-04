#include "speed.h"

int
c_get_speed (lua_State *l)
{
    const char * ifa = lua_tostring(l, -1);
        
    struct rtnl_link *link;
    struct nl_sock *socket;
    uint64_t kbytes_in, kbytes_out, packets_in, packets_out;

    socket = nl_socket_alloc ();
    nl_connect (socket, NETLINK_ROUTE);

    if (rtnl_link_get_kernel (socket, 0, ifa, &link) >= 0)
        {
            kbytes_in = rtnl_link_get_stat (link, RTNL_LINK_RX_BYTES);
            kbytes_out = rtnl_link_get_stat (link, RTNL_LINK_TX_BYTES);
            rtnl_link_put (link);
        }

    lua_newtable(l);
    lua_pushinteger(l, kbytes_in);
    lua_setfield(l, -2, "download");

    lua_pushinteger(l, kbytes_out);
    lua_setfield(l, -2, "upload");

    nl_socket_free (socket);
    return 1;
}
