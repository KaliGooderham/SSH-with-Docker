# SSH-with-Docker
A simple Dockerfile which allows for the user to clone the repository down, start the container, and be able to SSH inside. 


## Dockerfile Setup
There are a few things that could be changed within the Dockerfile to make it usable for the intended purposes. The `EXPOSE` option is, in the repository, set to port 2220. This port refers to the port being used within the container. If the user does not want port 2220 to be in use, then this will have to be changed. As a note, this will also change the `docker run` command when using the `-p` detailed in "Creating the Container". 
The other change would be in the line reading `RUN echo "root:PASSHERE" | chpasswd`. The "PASSHERE" is going to be changed to whatever the developer wants the password to be when a user SSHs into the container.

## Creating the Container
Once the repository is cloned down, open a terminal in the folder. 
The first step is creating the image, with `docker build .` - if you want the image with a specific tag, add a `-t` flag with the tag name: `docker build . -t IMAGE_NAME`.

Once this builds, it should pop up when `docker images` is run. The next step is to run the container, which is done by `docker run -it -p <HOST_PORT>:<CONTAINER_PORT> IMAGE_ID/NAME`.
The `-it` flag allows for the container to be interacted with and not exit immediately after it is ran. The `-p` flag is for port mapping, since a container is in its own world. The container has to have access to the outside, and without the `-p` flag, there would be no way for it to do so. For example, if we are wanting to expose port 2220 from the container and have it map to our computer port 2220, we use `-p 2220:2220`. 
If for any reason, you do not want your container to be using port 2220, change the `EXPOSE` option in the `Dockerfile`.  


Example with host port and container port as 2220, and image ID tagged as 'openssh': `docker run -it -p 2220:2220 openssh`.


Once the `docker run` command is run, the user cannot interact with that terminal. If the user wants to get out of the container, they will use `Ctrl+p then Ctrl+q`.


## Using SSH for Getting Inside Container
In another terminal, use `ssh root@localhost -p <PORT_ON_HOST>`. The `PORT_ON_HOST` refers to whichever port the container port is being mapped to. Think of a tube connecting from the selected port in the container to your selected port on your host. You want to select the port which you have access to - the host port. In the example of mapping port 2220 from the container to 2220 on the host, the port with the `-p` is `2220`. If the container port were to be 2220, but the host port were to be 8080, then the command would be `ssh root@localhost -p 8000'. This would also mean that the command for `docker run` would change to `docker run -it -p 8080:2220 <IMAGE_ID>`.  


Example: `ssh root:password_here -p 2220`

## Additions to the Dockerfile
If any additions need to be made to the setup of the Dockerfile to make it a different server, adding RUN commands are likely going to be the way to go.
