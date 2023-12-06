#ifndef INCLUDE_EVENT_BASE_HPP
#define INCLUDE_EVENT_BASE_HPP

#include <event2/event.h>
#include <unordered_map>

namespace libev {

class Event;

class EventBase {
    private:
        event_base* base;
        std::unordered_map<evutil_socket_t, Event*> events;

    public:
        EventBase();
        EventBase(EventBase& eb) = delete;
        EventBase& operator=(EventBase eb) = delete;
        EventBase(EventBase&& eb) = default;
        ~EventBase();

        Event* new_event(evutil_socket_t fd, short what, event_callback_fn cb);
        Event* new_event(evutil_socket_t fd, short what, event_callback_fn cb, void *arg);
        int run();
        int run(bool once, bool blocking, bool exit_on_empty);
        bool loopexit();
        bool loopexit(const timeval *tv);
        bool loopbreak();
        bool did_exit();
        bool did_break();
        bool loopcontinue();
        void dump_status();
        void dump_status(FILE* f);
        int foreach(event_base_foreach_event_cb cb, void* looparg);
        bool set_num_priorities(int n);
        Event* get_running_event();
};

}

#endif