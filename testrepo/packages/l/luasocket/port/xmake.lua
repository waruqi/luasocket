add_rules("mode.debug", "mode.release")
add_requires("luajit", {configs = {shared = true}})

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
            target:add("syslinks", "Ws2_32")
        else 
            target:add("files", "src/usocket.c")
        end
    end)


target("luasocket")
    set_kind("shared")
    add_deps("common")
    add_packages("luajit")
    add_rules("plat_socket")
    add_files(
        "src/luasocket.c",  "src/auxiliar.c",   "src/except.c",     "src/timeout.c", 
        "src/buffer.c",     "src/io.c",         "src/inet.c",       "src/tcp.c", 
        "src/udp.c",        "src/select.c",     "src/options.c",    "src/compat.c"
    )
    add_headerfiles(
        "src/luasocket.h",  "src/compat.h" 
    )
    add_installfiles("src/*.lua")


target("mime")
    set_kind("shared")
    add_deps("common")
    add_packages("luajit")
    add_files("src/mime.c", "src/compat.c")
    add_headerfiles("src/mime.h")

