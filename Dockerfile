# ============================================
# Dockerfile cho YouTube Clone (React App)
# Multi-stage build: Node.js build  Nginx serve
# ============================================

#  Stage 1: BUILD 
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files TRƯỚC (tận dụng Docker layer cache)
COPY package*.json ./

# Cài TẤT CẢ dependencies (cần devDeps cho react-scripts build)
RUN npm ci

# Copy source code
COPY . .

# [MỚI] Truyền API Key vào lúc build để React đóng gói vào JS tĩnh
ARG REACT_APP_RAPID_API_KEY
ENV REACT_APP_RAPID_API_KEY=$REACT_APP_RAPID_API_KEY

# Build React app  tạo folder /app/build (HTML/CSS/JS tĩnh)
RUN npm run build


#  Stage 2: PRODUCTION 
FROM nginx:1.25-alpine

# Copy build output từ stage 1
COPY --from=builder /app/build /usr/share/nginx/html

# Best Practice: Chạy bằng non-root user
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

USER nginx

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -q --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
