cmake_minimum_required(VERSION 3.21)
project(QGuiApp VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CXX_STANDARD 17)
set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_PREFIX_PATH $ENV{QTMSVCDIR})

# ========= Set directories
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")
#set(ANDROID_J_DIR "${CMAKE_SOURCE_DIR}/android/src/org/qtproject/example/QGuiApp/")

# ========= Include directories
include_directories(${SOURCE_DIR})
include_directories(${INCLUDE_DIR})
include_directories(${ANDROID_J_DIR})

# ========= Add directories files
file(GLOB_RECURSE SOURCES
    "${SOURCE_DIR}/*.cpp"
    "${INCLUDE_DIR}/*.h"
#    "${ANDROID_J_DIR}/*.java"
)

# ========= Include libraries
find_package(Qt6 COMPONENTS Gui Quick QuickControls2 REQUIRED)

# ========= Add executable
qt_add_executable(${CMAKE_PROJECT_NAME}
    ${SOURCES}
)

# ========= Add qml medule
qt_add_qml_module(${CMAKE_PROJECT_NAME}
    URI mainLib
    VERSION 1.0
    QML_FILES
    interfaces/main.qml
    interfaces/LoginPage.qml
    interfaces/CanvasPage.qml
    interfaces/CommentCumponent.qml
    interfaces/ReplyCumponent.qml
    interfaces/MyTabBar.qml
    interfaces/NavBar.qml

    # Debug
    # interfaces/ZoomTest.qml
    RESOURCES
)

# ========= Add resources
qt_add_resources(${CMAKE_PROJECT_NAME} "${CMAKE_PROJECT_NAME}"
    PREFIX
        "/"
    FILES
    resources/images/stackview-backarrow-dark.png
    resources/images/stackview-backarrow-dark@2x.png
    resources/images/stackview-backarrow-dark@3x.png
    resources/images/stackview-backarrow-light@2x.png
    resources/images/stackview-backarrow-light@3x.png
    resources/images/stackview-backarrow-light.png
    resources/images/arrow-indicator-dark.png
    resources/images/arrow-indicator-dark@2x.png
    resources/images/arrow-indicator-dark@3x.png
    resources/images/arrow-indicator-light.png
    resources/images/arrow-indicator-light@2x.png
    resources/images/arrow-indicator-light@3x.png
    resources/images/list.png
    resources/images/settings@3x.png
    resources/images/settings@2x.png
    resources/images/settings.png
    resources/images/list@3x.png
    resources/images/list@2x.png
    resources/images/add-new@3x.png
    resources/images/add-new.png
    resources/images/add-new@2x.png
    resources/images/home.png
    resources/images/home@2x.png
    resources/images/home@3x.png
    resources/images/user.png
    resources/images/user@2x.png
    resources/images/user@3x.png
    resources/images/comment.png
    resources/images/comment@2x.png
    resources/images/comment@3x.png
    resources/images/add.png
    resources/images/add@2x.png
    resources/images/add@3x.png
    
    #App images
    resources/images/Bitmap.png
    resources/images/Pic_Circle.png
    resources/images/71z05dWWLHL.jpg

    #App icons
    resources/icons/delete.png
    resources/icons/delete@2x.png
    resources/icons/delete@3x.png
    resources/icons/pen.png
    resources/icons/pen@2x.png
    resources/icons/pen@3x.png
    resources/icons/reply.png
    resources/icons/reply@2x.png
    resources/icons/reply@3x.png
)

# ========= Cnfigure macOS package
if(APPLE)
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES MACOSX_BUNDLE TRUE)
endif()


# ========= Configure Android package
if(ANDROID)

#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR ${ANDROID_PACKAGE_SOURCE_DIR})
#    add_custom_target(cmake_android_package
#        SOURCES
#        ${ANDROID_PACKAGE_SOURCE_DIR}/AndroidManifest.xml
#        ${ANDROID_PACKAGE_SOURCE_DIR}/build.gradle
#        ${ANDROID_PACKAGE_SOURCE_DIR}/grable.properties
#        ${ANDROID_PACKAGE_SOURCE_DIR}/res/values/libs.xml
#    )

    # ========= Include openssl
    include(FetchContent)
    FetchContent_Declare(
        android_openssl
        DOWNLOAD_EXTRACT_TIMESTAMP true
        URL https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip

        # URL_HASH MD5=c97d6ad774fab16be63b0ab40f78d945 # optional
    )
    FetchContent_MakeAvailable(android_openssl)
    include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)

endif()

# ========= Link target subDirectories
target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC src)
target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC include)
#target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC android/src/org/qtproject/example/QGuiApp)

# ========= Link libraries
target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
)
