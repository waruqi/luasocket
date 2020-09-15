set_xmakever("2.3.4")
add_rules("mode.debug", "mode.release")

add_requires("luajit", { configs = { shared = true }})

target("common")
    -- no 'set_kind("xxx")' function call means this target is an object/interface
    if is_host("windows") then
        add_defines("WIN32", "_WINDOWS", "_USRDLL", "NDEBUG", { public = true })
        add_defines("_CRT_SECURE_NO_WARNINGS", "LUASOCKET_API=__declspec(dllexport)", { public = true })
    else
        add_defines("-DLUASOCKET_")
    end
    add_includedirs("src", { public = true })


rule("plat_socket")
    on_load(function(target) 
        if is_host("windows") then 
            target:add("files", "src/wsocket.c")
            target:add("headerfiles", "src/wsocket.h")
            target:add("syslinks", "Ws2_32")
        else 
            target:add("files", "src/usocket.c")
            target:add("headerfiles", "src/usocket.h")
        end
    end)


target("luasocket")
    set_kind("shared")
    set_basename("socket/core")
    add_packages("luajit")
    add_rules("plat_socket")
    add_deps("common")
    add_files(
        "src/luasocket.c",  "src/auxiliar.c",   "src/except.c",     "src/timeout.c", 
        "src/buffer.c",     "src/io.c",         "src/inet.c",       "src/tcp.c", 
        "src/udp.c",        "src/select.c",     "src/options.c",    "src/compat.c"
    )
    add_headerfiles(
        "src/luasocket.h",  "src/auxiliar.h",   "src/except.h",     "src/timeout.h",
        "src/buffer.h",     "src/io.h",         "src/inet.h",       "src/tcp.h", 
        "src/udp.h",        "src/select.h",     "src/options.h",    "src/compat.h",  
        "src/socket.h"
    )
    on_install(function(package)
        cprint("${red}$(targetdir)")
        local prefix = is_host("linux") and "/lib" or "/"
        os.cp(package:targetdir() .. prefix .. "socket", package:installdir() .. "/socket")
        os.cp(package:targetdir() .. prefix .. "mime", package:installdir() .. "/mime")
        os.cp("src/*.lua", package:installdir())
        os.cp("src/luasocket.h", package:installdir() .. "/include")
        os.cp("src/compat.h", package:installdir() .. "/include")
    end)

target("mime")
    set_kind("shared")
    set_basename("mime/core")
    add_deps("common")
    add_packages("luajit", { kind = "shared"})
    add_files("src/mime.c", "src/compat.c")
    add_headerfiles("src/mime.h")

