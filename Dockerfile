FROM node:20-alpine AS base
ARG APP_NAME="core"
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
COPY . /app
WORKDIR /app

FROM base AS build
RUN pnpm install --frozen-lockfile
RUN pnpm run build $APP_NAME

FROM base AS prod-deps
RUN pnpm install --prod --frozen-lockfile

FROM node:20-alpine AS prod
ARG APP_NAME="core"
COPY --from=build /app/dist /app/dist
COPY --from=prod-deps /app/node_modules /app/node_modules
ENV APP_PATH="/app/dist/apps/$APP_NAME/main.js"
CMD node $APP_PATH