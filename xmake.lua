add_rules("mode.debug", "mode.release")
add_repositories("test-repo " ..  os.projectdir() .. "/testrepo")

add_requires("luasocket")

target("test")
    set_kind("binary")
    add_packages("luasocket")
    add_files("src/*.cpp")

