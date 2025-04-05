#ifndef INCLUDE_EVENT_HPP
#define INCLUDE_EVENT_HPP

#include <event2/event.h>

#include "event-base.hpp"

namespace libev {

class Event {
    private:
        event_base* base;
        event* ev;
        evutil_socket_t fd;
        short what;
        event_callback_fn cb;
        void* arg;

    public:
        Event(event_base* base, evutil_socket_t fd, short what, event_callback_fn cb, void* args);
        Event(Event& e);
        Event(Event&& e);
        ~Event();

        Event& operator=(Event& e);
        Event& operator=(Event&& e);
        
        bool add();
        bool add(const timeval* tv);
        bool remove();
        bool set_priority(int priority);
        bool is_active(short flags);
        bool is_active(short flags, timeval* tv_out);
};

}

#endif