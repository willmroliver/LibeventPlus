#include <memory>
#include <event2/event.h>

#include "event.hpp"
#include "event-base.hpp"

using namespace libev;

Event::Event(event_base* base, evutil_socket_t fd, short what, event_callback_fn cb, void* arg):
    base { base },
    ev { event_new(base, fd, what, cb, arg) },
    fd { fd },
    what { what },
    cb { cb },
    arg { arg }
{}

Event::Event(event* ev) {
    event_base* base;
    evutil_socket_t fd;
    short what;
    event_callback_fn cb;
    void* arg;

    event_get_assignment(ev, &base, &fd, &what, &cb, &arg);
}

Event::Event(Event& e) {
    ev = event_new(e.base, e.fd, e.what, e.cb, e.arg);
    event_get_assignment(ev, &base, &fd, &what, &cb, &arg);
}

Event::Event(Event&& e):
    base { e.base },
    ev { e.ev },
    fd { e.fd },
    what { e.what },
    cb { e.cb },
    arg { e.arg }
{
    e.base = nullptr;
    e.ev = nullptr;
    e.fd = 0;
    e.what = 0;
    e.arg = nullptr;
}

Event::~Event() {
    event_free(ev);
}

Event& Event::operator=(Event& e) {
    ev = event_new(e.base, e.fd, e.what, e.cb, e.arg);
    event_get_assignment(ev, &base, &fd, &what, &cb, &arg);

    return *this;
}

Event& Event::operator=(Event&& e) {
    base = e.base;
    ev = e.ev;
    fd = e.fd;
    what = e.what;
    cb = e.cb;
    arg = e.arg;

    e.base = nullptr;
    e.ev = nullptr;
    e.fd = 0;
    e.what = 0;
    e.arg = nullptr;
    
    return *this;
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