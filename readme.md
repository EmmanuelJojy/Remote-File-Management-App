# Server Client Program
---
## Overview
The server client program implements a Flutter Client and Python based server for remote file management. The target cases include creating, deleting, viewing and editing a file. Additionally the user can execute `restricted` remote commands at the server. The project makes use of Transmission Control Protocol (TCP) sockets for communication. 
 
## Server Side Script
Server actions avoid direct native system calls making the server platform independent. Flutter codebase, by default is developed with platform independency making the entire project platform independent  
> To start server, from **/server_script/** execute the following:
> `python server.py`  
> All server actions on directory **/server_script/reactor/**  
> :electric_plug: Default port is set to `65432`  
> :warning: **Make sure your firewall provides access across the web**

## Client Side Program
Client side leverages the functionalities of Flutter Framework and Dart combined. The TCP logic is purely based on dart or specifically `Socket` class of  `dart:io` library.  
:heavy_check_mark: `android.permission.INTERNET` granted at install time for targeted android devices.  
:hourglass_flowing_sand: Default communication timeout set to `500ms`. Unexpected error can be anticipated if by some reason timeout is `> 500ms`.


