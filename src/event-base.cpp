#include <memory>
#include <event2/event.h>

#include "event-base.hpp"
#include "event.hpp"

using namespace libev;

EventBase::EventBase(): 
    base { event_base_new() } 
{}

EventBase::~EventBase() {
    event_base_free(base);
}

Event* EventBase::new_event(evutil_socket_t fd, short what, event_callback_fn cb) {
    events[fd] = new Event(base, fd, what, cb, event_self_cbarg());
    return events[fd];
}

Event* EventBase::new_event(evutil_socket_t fd, short what, event_callback_fn cb, void *arg) {
    events[fd] = new Event(base, fd, what, cb, arg);
    return events[fd];
}

int EventBase::run() {
    return event_base_dispatch(base);
}

int EventBase::run(bool blocking, bool once, bool exit_on_empty) {
    int flags = (blocking ? 0 : EVLOOP_NONBLOCK)
    |(once ? EVLOOP_ONCE : 0)
    |(exit_on_empty ? 0 : EVLOOP_NO_EXIT_ON_EMPTY);
    
    return event_base_loop(base, flags);
}

bool EventBase::loopexit() {
    return event_base_loopexit(base, nullptr) == 0;
}

bool EventBase::loopexit(const timeval *tv) {
    return event_base_loopexit(base, tv) == 0;
}

bool EventBase::loopbreak() {
    return event_base_loopbreak(base) == 0;
}

bool EventBase::did_exit() {
    return event_base_got_exit(base);
}

bool EventBase::did_break() {
    return event_base_got_break(base);
}

bool EventBase::loopcontinue() {
    return event_base_loopcontinue(base) == 0;
}

void EventBase::dump_status() {
    event_base_dump_events(base, stdout);
}

void EventBase::dump_status(FILE* fd) {
    event_base_dump_events(base, fd);
}

int EventBase::foreach(event_base_foreach_event_cb cb, void* arg) {
    return event_base_foreach_event(base, cb, arg);
}

bool EventBase::set_num_priorities(int n) {
    return event_base_priority_init(base, n) == 0;
}

Event* EventBase::get_running_event() {
    return new Event(event_base_get_running_event(base));
}