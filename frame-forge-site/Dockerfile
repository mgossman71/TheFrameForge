# 1. Use Node base image
FROM node:18-alpine

# 2. Set working directory
WORKDIR /app

# 3. Copy dependencies and install
COPY package.json package-lock.json* ./
RUN npm install

# 4. Copy rest of the app
COPY . .

# 5. Build the Next.js app
RUN npm run build

# 6. Expose port and start
EXPOSE 3000
CMD ["npm", "start"]

