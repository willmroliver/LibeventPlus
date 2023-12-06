#include <memory>
#include <event2/event.h>

#include "event.hpp"
#include "event-base.hpp"

using namespace libev;

Event::Event(event_base* base, evutil_socket_t fd, short what, event_callback_fn cb, void* arg):
    ev { event_new(base, fd, what, cb, arg) }
{}

Event::Event(event* ev): ev { ev } {};

Event::~Event() {
    event_free(ev);
}

bool Event::add() {
    return event_add(ev, nullptr) == 0;
}

bool Event::add(const timeval* tv) {
    return event_add(ev, tv) == 0;
}

bool Event::remove() {
    return event_del(ev) == 0;
}

bool Event::set_priority(int priority) {
    return event_priority_set(ev, priority) == 0;
}

bool Event::is_active(short flags) {
    return event_pending(ev, flags, nullptr);
}

bool Event::is_active(short flags, timeval* tv_out) {
    return event_pending(ev, flags, tv_out);
}