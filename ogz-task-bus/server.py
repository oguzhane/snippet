import socket
import os, os.path
import time
import json
import logging

"""
SET RUN DEFINITIONS OF TASKS HERE
"""
def run_show_konsole(params):
    print("run show konsole body",params)
    os.system(
            """

            """
                )

"""
SET YOUR TASKS HERE
"""
tasks = [
            {
                'task':"show-konsole",
                'run':run_show_konsole
            }
        ]


sock_file = "/tmp/ogz_task_bus.sock"
if os.path.exists(sock_file):
  os.remove(sock_file)
 
print("Opening socket...")
server = socket.socket( socket.AF_UNIX, socket.SOCK_DGRAM )
server.bind(sock_file)
 
print("Listening...")
while True:
  datagram = server.recv( 1024 )
  if not datagram:
    break
  else:
    datagram = datagram.decode('utf-8', 'ignore').strip()
    # print("-" * 20)
    print("message received: ")
    print(datagram)

    #print(type(datagram))
    
    if "__STOP__" == datagram:
      break
    
    #task = json.loads(datagram)
    
    try:
        task_msg = json.loads(datagram)
        print("task->")
        print(task_msg)
        task = None
        for t in tasks:
            if t['task'] == task_msg['task']:
                task = t
                break
        if not task is None:
            task['run']('param' in task_msg and task_msg['param'] or '')
            print("task {0} invoked".format(task_msg['task']))
        else:
            print("TASK NOT FOUND: {0}".format(datagram))


        """
        print("task#task " + task['task'])
        print("task#params " + task['params'])
        print("task#params " + task[0])
        print("task#params {0}".format((task[1], task[2])))
        """
    except Exception as e:
        print("invalid message: {0}".format(datagram))
        logging.error(e, exc_info=True)
    
print("-" * 20)
print("Shutting down...")
server.close()
os.remove(sock_file )
print("Done")
