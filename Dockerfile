# 1. Build Phase
FROM node:alpine as builder

WORKDIR '/app'

# Install Dependencies
COPY package.json .

RUN npm install

# Copy all files
COPY . .

CMD ["npm", "run", "build"]

# 2. Run Phase (Copy build result from previous phase)
FROM nginx

#Elastic BeansTalk will use this to do port mapping. (No effect when use Docker CLI)
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html