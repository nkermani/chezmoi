/*
 * simple_focus.c
 * A minimal X11 window focuser to replace wmctrl at 42.
 * Compiles with: gcc simple_focus.c -o simple_focus -lX11
 */

#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/Xutil.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* get_string_property(Display* display, Window window, Atom property) {
    Atom actual_type;
    int actual_format;
    unsigned long nitems;
    unsigned long bytes_after;
    unsigned char* prop = NULL;
    
    if (XGetWindowProperty(display, window, property, 0, 1024, False, AnyPropertyType,
                           &actual_type, &actual_format, &nitems, &bytes_after, &prop) == Success) {
        if (prop) {
            return (char*)prop;
        }
    }
    return NULL;
}

int contains_ignore_case(const char* haystack, const char* needle) {
    if (!haystack || !needle) return 0;
    
    char* h = strdup(haystack);
    char* n = strdup(needle);
    
    for(int i = 0; h[i]; i++) h[i] = tolower(h[i]);
    for(int i = 0; n[i]; i++) n[i] = tolower(n[i]);
    
    int result = strstr(h, n) != NULL;
    
    free(h);
    free(n);
    return result;
}

void focus_window(Display* display, Window window) {
    XRaiseWindow(display, window);
    XSetInputFocus(display, window, RevertToPointerRoot, CurrentTime);
    
    XEvent event;
    long mask = SubstructureRedirectMask | SubstructureNotifyMask;
    
    event.xclient.type = ClientMessage;
    event.xclient.serial = 0;
    event.xclient.send_event = True;
    event.xclient.message_type = XInternAtom(display, "_NET_ACTIVE_WINDOW", False);
    event.xclient.window = window;
    event.xclient.format = 32;
    event.xclient.data.l[0] = 1;
    event.xclient.data.l[1] = CurrentTime;
    event.xclient.data.l[2] = 0;
    event.xclient.data.l[3] = 0;
    event.xclient.data.l[4] = 0;
    
    XSendEvent(display, DefaultRootWindow(display), False, mask, &event);
    XMapRaised(display, window);
    XFlush(display);
}

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <search_string>\n", argv[0]);
        return 1;
    }

    Display* display = XOpenDisplay(NULL);
    if (!display) {
        fprintf(stderr, "Cannot open display\n");
        return 1;
    }

    Atom net_client_list = XInternAtom(display, "_NET_CLIENT_LIST", False);
    Atom wm_class = XInternAtom(display, "WM_CLASS", False);
    Atom net_wm_name = XInternAtom(display, "_NET_WM_NAME", False);
    Atom wm_name = XInternAtom(display, "WM_NAME", False);

    Atom actual_type;
    int actual_format;
    unsigned long nitems;
    unsigned long bytes_after;
    unsigned char* prop = NULL;

    if (XGetWindowProperty(display, DefaultRootWindow(display), net_client_list, 0, 1024, False, AnyPropertyType,
                           &actual_type, &actual_format, &nitems, &bytes_after, &prop) != Success) {
        fprintf(stderr, "Cannot get client list\n");
        return 1;
    }

    Window* list = (Window*)prop;
    int found = 0;

    Window target_window = 0;
    for (long i = nitems - 1; i >= 0; i--) {
        Window w = list[i];
        int is_target = 0;
        
        XClassHint class_hint;
        if (XGetClassHint(display, w, &class_hint)) {
            if (contains_ignore_case(class_hint.res_name, argv[1]) || 
                contains_ignore_case(class_hint.res_class, argv[1])) {
                is_target = 1;
            }
            if (class_hint.res_name) XFree(class_hint.res_name);
            if (class_hint.res_class) XFree(class_hint.res_class);
        }
        
        if (!is_target) {
            char* name = get_string_property(display, w, net_wm_name);
            if (!name) name = get_string_property(display, w, wm_name);
            if (name) {
                if (contains_ignore_case(name, argv[1])) {
                    is_target = 1;
                }
                XFree(name);
            }
        }
        
        if (is_target) {
            target_window = w;
            break;
        }
    }

    if (target_window) {
        Atom net_wm_window_type = XInternAtom(display, "_NET_WM_WINDOW_TYPE", False);
        Atom net_wm_window_type_normal = XInternAtom(display, "_NET_WM_WINDOW_TYPE_NORMAL", False);
        
        for (long i = 0; i < nitems; i++) {
            Window w = list[i];
            if (w == target_window) continue;
            
            Atom type_actual_type;
            int type_actual_format;
            unsigned long type_nitems, type_bytes;
            unsigned char* type_prop = NULL;
            
            int is_normal = 1;
            
            if (XGetWindowProperty(display, w, net_wm_window_type, 0, 1024, False, XA_ATOM,
                                   &type_actual_type, &type_actual_format, &type_nitems, &type_bytes, &type_prop) == Success) {
                if (type_prop) {
                    Atom* atoms = (Atom*)type_prop;
                    is_normal = 0;
                    for (unsigned long j = 0; j < type_nitems; j++) {
                        if (atoms[j] == net_wm_window_type_normal) {
                            is_normal = 1;
                            break;
                        }
                    }
                    XFree(type_prop);
                }
            }
            
            if (is_normal) {
                XIconifyWindow(display, w, DefaultScreen(display));
            }
        }
        
        focus_window(display, target_window);
        found = 1;
    }

    XFree(prop);
    XCloseDisplay(display);
    
    return found ? 0 : 1;
}
