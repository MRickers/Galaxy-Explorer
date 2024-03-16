include("${PROJECT_SOURCE_DIR}/cmake/CPM.cmake")
CPMAddPackage(
    NAME FMT_LIB
    GITHUB_REPOSITORY fmtlib/fmt
    GIT_TAG 10.2.1 
)

CPMAddPackage(
        NAME RAYLIB
        GITHUB_REPOSITORY raysan5/raylib
        GIT_TAG 5.0
)