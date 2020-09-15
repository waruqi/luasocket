package("luasocket")

    set_homepage("http://w3.impa.br/~diego/software/luasocket/")
    set_description([[Network support for the Lua language.]])
  
    set_urls("https://github.com/paul-reilly/luasocket.git")
    add_versions("3.0.3-rc1", "cc1175f117aa57693228782a96756d8a235aae45")

    add_deps("luajit", {configs = {shared = true}})
    add_includedirs("include")

    on_install("windows", "linux", "macosx", "bsd", "android", "iphoneos", function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        os.cp(path.join(package:scriptdir(), "port", "xmake.lua"), "xmake.lua")
        import("package.tools.xmake").install(package, configs)
    end)

    

    -- on_test(function(package)
    --   assert(
    --     package:check_cxxsnippets(
    --       { 
    --         test = [[
    --           #include <luasocket.h
    --           void() {}
    --         ]]
    --       },
    --       {
    --         includes = "include",
    --         configs = { languages = "c++11" }
    --       }
    --     )
    --     ,
    --     "simple include test failed"
    --   )
    -- end)
