### This dockerfile is for production and we are using multiple step builds 1.Build 2.Run

### Use an existing docker image as a base
FROM node as builder

### define working directory
WORKDIR /app

### if you make any changes to package.json
COPY package.json ./

### Download and install a dependency
RUN npm install

### make all the files inside this folder available to the container
COPY ./ ./

### Tell the image what do do when it starts as a container
RUN npm run build

### Use nginx base image to get nginx
FROM nginx

## Copy the build folder from above process , ngnix uses this 
COPY --from=builder /app/build /usr/share/nginx/html
