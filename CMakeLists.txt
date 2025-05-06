cmake_minimum_required(VERSION 3.29)

project(RenameExportedMacPhotos VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

add_subdirectory(Renamer)

qt_add_executable(RenameExportedMacPhotos
  main.cpp
)

qt_add_qml_module(RenameExportedMacPhotos
    URI Primary
    RESOURCE_PREFIX /
    VERSION 1.0
    QML_FILES Main.qml
)

set_target_properties(RenameExportedMacPhotos PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(RenameExportedMacPhotos
  PRIVATE Qt6::Quick
  RenamerLibplugin
)

install(TARGETS RenameExportedMacPhotos
BUNDLE DESTINATION .
LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
