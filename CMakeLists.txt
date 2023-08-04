cmake_minimum_required(VERSION 3.21)
project(QReviewed VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CXX_STANDARD 17)
set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_PREFIX_PATH $ENV{QTMSVCDIR})

# ========= Set directories
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")

# ========= Include directories
include_directories(${SOURCE_DIR})
include_directories(${INCLUDE_DIR})

# ========= Add directories files
file(GLOB_RECURSE SOURCES
    "${SOURCE_DIR}/*.cpp"
    "${INCLUDE_DIR}/*.h"
)

# ========= Include libraries
find_package(Qt6 COMPONENTS Gui Quick Svg REQUIRED)

# ========= Add executable
qt_add_executable(${CMAKE_PROJECT_NAME}
    ${SOURCES}
)

# ========= Set Resources
set(RESOURCE_DIR

    # fonts
    "resources/fonts/fonts.txt"

    # images
    "resources/images/cover.png"
    "resources/images/Profile.jpg"

    # icons
    "resources/icons/pin-circle.svg"
    "resources/icons/pin-list.svg"
    "resources/icons/pin.svg"
    "resources/icons/back.svg"
    "resources/icons/comment.svg"
)

# ========= Add qml medule
qt_add_qml_module(${CMAKE_PROJECT_NAME}
    URI mainLib
    VERSION 1.0
    QML_FILES

    # Pages
    interfaces/main.qml
    interfaces/CanvasPage.qml
    interfaces/CommentPage.qml

    # components
    interfaces/components/MyPin.qml
    interfaces/components/MyComment.qml
    interfaces/components/ReplyDelegate.qml
    RESOURCES
    ${RESOURCE_DIR}
)

# ========= Link target subDirectories
target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC src)
target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC include)

# ========= Link libraries
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE Qt6::Gui Qt6::Quick Qt6::Svg)