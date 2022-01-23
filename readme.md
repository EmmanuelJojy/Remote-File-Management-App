# Server Client Program 
## Overview
The server client program implements a Flutter Client and Python based server for remote file management. The target cases include creating, deleting, viewing and editing a file. Additionally the user can execute `restricted` remote commands at the server. The project makes use of Transmission Control Protocol (TCP) sockets for communication. 
 
## Server Side Script
Server actions avoid direct native system calls making the server platform independent. Flutter codebase, by default is developed with platform independency making the entire project platform independent  
> To start server run `server.pyc`.Alternatively, from **/server_script/** execute the following:
> ```
> python server.py
> ```  
> :triangular_flag_on_post: All server actions on directory `./reactor/`   
> :electric_plug: Default port is set to `:65432`.  

### Server Programming Interface:  
| Server Action | Command | Response |
| --- | --- |  -------- |
| Create File | `cf {filename}`  | `1` indicating successful operation else `0` |  
| View File | `vf {filename}`  | `{file data} 1` if  successful else `0`  
| Delete File | `df {filename}`  | `1` indicating successful operation else `0` |  
| Edit File | `cf {filename} {data}`  | `1` indicating successful operation else `0` |  
| Request Path | `cd`  | Absolute Server Path. (Time out of `500ms`) |

## Client Side Program
Client side leverages the functionalities of Flutter Framework and Dart combined. The TCP logic is purely built over dart or specifically using `Socket` class of  `dart:io` library.  
>:heavy_check_mark: `android.permission.INTERNET` granted at install for target android devices.  
:hourglass_flowing_sand: Default communication timeout set to `500ms`.

## Project Screenshots
![Server Screenshot Here](/assets/server_live.png) Server Live with *MyDevice* connected.



