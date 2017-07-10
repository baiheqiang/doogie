
QT += core gui widgets
TARGET = doogie
TEMPLATE = app
DEFINES += QT_DEPRECATED_WARNINGS
CONFIG += c++14

# We want a console window for logs during debug
debug:CONFIG += console

# Keep all sources and headers in alphabetical order

SOURCES += \
    browser_stack.cc \
    browser_widget.cc \
    cef.cc \
    cef_handler.cc \
    cef_widget.cc \
    main.cc \
    main_window.cc \
    page_tree.cc \
    page_tree_dock.cc \
    page_tree_item.cc

HEADERS  += \
    browser_stack.h \
    browser_widget.h \
    cef.h \
    cef_handler.h \
    cef_widget.h \
    main_window.h \
    page_tree.h \
    page_tree_dock.h \
    page_tree_item.h

RESOURCES += \
    doogie.qrc

release:PROFILE = Release
debug:PROFILE = Debug

INCLUDEPATH += $$(CEF_DIR)

win32 {
    SOURCES += \
        cef_widget_win.cc \
        cef_win.cc

    LIBS += -luser32
    LIBS += -L$$(CEF_DIR)/$$PROFILE -llibcef
    LIBS += -L$$(CEF_DIR)/libcef_dll_wrapper/$$PROFILE -llibcef_dll_wrapper

    # Chromium reads the manifest, needs a specific one
    # See http://magpcss.org/ceforum/viewtopic.php?f=6&t=14721
    CONFIG -= embed_manifest_exe
    RC_FILE = doogie.rc
}

unix {
    SOURCES += \
        cef_embed_window_linux.cc \
        cef_linux.cc \
        cef_widget_linux.cc
    HEADERS += \
        cef_embed_window_linux.h
    LIBS += -lX11
    LIBS += -L$$(CEF_DIR)/$$PROFILE -lcef
    LIBS += -L$$(CEF_DIR)/libcef_dll_wrapper -lcef_dll_wrapper_$$PROFILE
    QMAKE_RPATHDIR += $ORIGIN

    release:MOC_DIR = release
    release:OBJECTS_DIR = release
    release:DESTDIR = release
    debug:MOC_DIR = debug
    debug:OBJECTS_DIR = debug
    debug:DESTDIR = debug
}