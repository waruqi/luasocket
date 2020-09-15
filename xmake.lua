add_rules("mode.debug", "mode.release")
add_repositories("test-repo " ..  os.projectdir() .. "/testrepo")
set_languages("c++17")

add_requires("luajit", "luasocket")

target("test")
    set_kind("binary")
    add_packages("luajit", "luasocket")
    add_files("src/*.cpp")

