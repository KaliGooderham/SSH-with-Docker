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

