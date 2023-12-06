#include <event2/event.h>

#include "event-base.hpp"

namespace libev {

class Event {
    private:
        std::unique_ptr<event> ev;

    public:
        Event(event_base* base, evutil_socket_t fd, short flags, event_callback_fn cb, void* args);
        Event(event* ev);
        Event(Event& e) = delete;
        Event& operator=(Event& e) = delete;
        Event(Event&& e) = default;
        ~Event();

        bool add();
        bool add(const timeval* tv);
        bool remove();
        bool set_priority(int priority);
        bool is_active(short flags);
        bool is_active(short flags, timeval* tv_out);
};

}