package("luasocket")

    set_homepage("http://w3.impa.br/~diego/software/luasocket/")
    set_description([[Network support for the Lua language.]])
  
    set_urls("https://github.com/paul-reilly/luasocket.git")
    add_versions("3.0.3-rc1", "cc1175f117aa57693228782a96756d8a235aae45")

    on_install("macosx", "linux", "windows", function (package)
        import("package.tools.xmake").install(package)
    end)

    add_includedirs("include")

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
    --         configs = { includes = "include", languages = "c++11" }
    --       }
    --     )
    --     , 
    --     "simple include test failed"
    --   )
    -- end)