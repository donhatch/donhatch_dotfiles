# by default gdb loads symbols from every shared library when it starts,
# which takes forever.
# we disable that here, so that on startup, it doesn't load any.
# at runtime, you can say "shared" to load them all,
# or "shared <substring>" to load symbols from all DSOs 
# containing the given substring.
set auto-solib-add off
# the following gives nice verbosity during .so loading,
# but it also gives some other undesired behavior :-(
set verbose on
