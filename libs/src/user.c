#include "user.h"

int
get_username (lua_State *l)
{
    __uid_t uid = getuid ();
    const struct passwd info = *getpwuid (uid);
    const char *user
        = strcmp (info.pw_gecos, "") ? info.pw_gecos : info.pw_name;

    lua_pushstring (l, user);

    return 1;
}

struct pam_response *reply;

int
simple_conversation (int num_msg, const struct pam_message **msg,
                     struct pam_response **resp, void *appdata_ptr)
{
    *resp = reply;
    return PAM_SUCCESS;
}

int
auth_current_user (lua_State *L)
{
    int retval;

    const char *pass = luaL_checkstring (L, -1);

    uid_t uid = getuid ();
    struct passwd *pw = getpwuid (uid);
    const char *user = pw->pw_name;

    pam_handle_t *pamh = NULL;
    struct pam_conv conv = { simple_conversation, NULL };
    retval = pam_start ("login", user, &conv, &pamh);

    reply = (struct pam_response *)malloc (sizeof (struct pam_response));

    if (retval == PAM_SUCCESS)
        {
            reply->resp = strdup (pass);
            reply->resp_retcode = 0;

            retval = pam_authenticate (pamh, 0);
        }

    lua_pushboolean (L, !retval);
    return 1;
}
