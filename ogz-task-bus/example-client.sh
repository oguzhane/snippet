# example task dispatch
echo '{"task":"show-konsole", "param":"myparam"}' | nc -uU /tmp/ogz_task_bus.sock
