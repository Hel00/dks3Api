from pyinjector import inject
import psutil

process_name = "DarkSoulsIII"
pid = None

for proc in psutil.process_iter():
    if process_name in proc.name():
       pid = proc.pid

inject(pid, "C:\\Users\\hel\\Documents\\NimWorkspace\\dark souls 3\\playerClass.dll")
