# Stage 1: Build the application
FROM node:18-alpine 

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .


# Expose the port Next.js will run on
EXPOSE 3000


# # Command to start the Next.js app
CMD ["npm", "run", "dev"]
