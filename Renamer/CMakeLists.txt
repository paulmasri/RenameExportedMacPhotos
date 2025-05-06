list(APPEND MODULE_SOURCE_FILES
    Renamer.h Renamer.cpp
)

qt_add_library(RenamerLib STATIC)

qt_add_qml_module(RenamerLib
    URI Renamer
    RESOURCE_PREFIX /
    VERSION 1.0
    SOURCES
    ${MODULE_SOURCE_FILES}
)

target_include_directories(RenamerLib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(RenamerLib
    PUBLIC Qt6::Core
)
