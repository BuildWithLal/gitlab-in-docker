FROM node:18-alpine

RUN apk add --no-cache libc6-compat

ENV NEXT_TELEMETRY_DISABLED=1 \
    HOSTNAME="0.0.0.0"

WORKDIR /app

# Install dependencies based on the preferred package manager
COPY ./app/package.json ./app/yarn.lock* ./

RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

COPY ./app .

CMD ["yarn", "dev"]
