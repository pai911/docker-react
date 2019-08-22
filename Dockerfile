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
COPY --from=builder /app/build /usr/share/nginx/html

