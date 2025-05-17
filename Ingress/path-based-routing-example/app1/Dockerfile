FROM node:18
WORKDIR /app
COPY . .
# This pins Express to version 4, avoiding the latest version of express@5, which introduces breaking changes and rewrites in routing internals.
RUN npm install express@4
CMD ["node", "index.js"]
