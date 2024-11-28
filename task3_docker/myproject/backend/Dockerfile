# Use the official Node.js image
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./
RUN npm install

# Copy all the source files (including index.js) to the container
COPY index*.js package*.json .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]

