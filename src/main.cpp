#include <iostream>
#include <luasocket.h>
#include <lua.hpp>

int main(int argc, char** argv)
{
    auto L = luaL_newstate();
    luaL_openlibs(L);
    if (luaL_dostring(L, R"N0R3P(

        local socket = require(socket.core)
        print('hello, from luajit')
        
    )N0R3P")) {
        std::cout << lua_tostring(L, -1) << "\n";
    }
    return 0;
}
