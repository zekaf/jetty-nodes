On Linux Debian/Ubuntu:

-- INSTALL COMPONENTS ---

1 - Install curl, git and uml-utilities
$ sudo apt-get -y install curl git uml-utilities

2 - Clone git repository to $HOME
$ cd $HOME
$ git clone https://github.com/zekaf/jetty-nodes.git

3 - Install OpenJDK 8, Ant and Maven
$ cd $HOME/jetty-nodes/node-0
$ ./install-openjdk-8.sh 
$ ./install-ant.sh
$ ./install-maven.sh

--- DEV AND TESTS ---

4 - Reset project:
$ ./sync-nodes.sh 0

5 - Compile code (and execute Jetty)
$ ./compile.sh war

5.1 - Open a new linux terminal

6 - Test XML REST Java client
$ ./runwar.sh XMLClient

7 - Test web service REST XML
$ curl http://node-0:8080/rest/xmlServices/student/James

8 - Test REST JSON Java client 
$ ./runwar.sh JsonClient
 
9 - Test web service REST JSON
$ curl http://node-0:8080/rest/employee/getEmployee

10 - Test create resource on browser:
http://node-0:8080/createresource.html

11 - Create temporary upload folder:
$ mkdir /tmp/upload

13 - Test upload on browser :
http://node-0:8080/fileUpload.html
(select resources/Sample.pdf )

14 - Verify upload
$ ls -all /tmp/upload
drwxrwxr-x  2 aluno aluno   60  Nov 27 19:05 .
drwxrwxrwt 16 aluno aluno   540 Nov 27 20:28 ..
-rw-rw-r--  1 aluno aluno  7696 Nov 27 20:28 Sample.pdf

15 - Copy file Sample.pdf to /tmp
$ cp /tmp/upload/Sample.pdf /tmp

16 - Delete document Sample.pdf from upload folder
$ rm /tmp/upload/Sample.pdf

17 - Test REST cliente upload
$ ./runwar.sh UploadFileTest

18 - Verificar upload
$ ls -all /tmp/upload
drwxrwxr-x  2 aluno aluno   60  Nov 27 19:05 .
drwxrwxrwt 16 aluno aluno   540 Nov 27 20:28 ..
-rw-rw-r--  1 aluno aluno  7696 Nov 27 20:28 Sample.pdf

18 - Test download from client browser:
http://node-0:8080/rest/download/pdf
 

--- PRODUCTION ---

11 - Finish process started on topic 5
$ Ctrl+c

12 - Create/Sync 2 nodes (node-1 and node-2) with $HOME folder
$ ./sync-nodes.sh 2 

13 - Start Jetty server from different nodes using different terminals:

node-0 terminal
$ cd $HOME/jetty-nodes/node-0/
$ ./jetty-server.sh start

node-1 terminal
$ cd $HOME/jetty-nodes/node-1/
$ ./jetty-server.sh start

node-2 terminal
$ cd $HOME/jetty-nodes/node-2/
$ ./jetty-server.sh start

14 - View Jetty server console (optional)
$ ./jetty-server.sh console
( Ctrl+c to finish)

15 - Verify Jetty server status(optional)
$ ./jetty-server.sh status

16 - To restart Jetty server (optional)
$ ./jetty-server.sh restart

17 - Stop Jetty server (optional)
$ ./jetty-server.sh stop


NOTE:
Source code folders
'src/main/java/com/rest/test'
'src/main/java/com/rest/crud'
'src/main/java/com/rest/howtodoinjava'


