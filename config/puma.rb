#!/usr/bin/env puma

workers 1
threads 1, 1

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
