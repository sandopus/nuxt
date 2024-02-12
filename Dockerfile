ARG NODE_VERSION=18.17.1

FROM node:${NODE_VERSION}

ARG BUN_VERSION=1.0.0

WORKDIR /app

RUN apt update && apt install -y bash curl unzip
RUN curl https://bun.sh/install | bash -s -- bun-v${BUN_VERSION}

ENV PATH="${PATH}:/root/.bun/bin"

COPY bun.lockb package.json ./

RUN bun install

COPY . .

RUN curl -sf https://gobinaries.com/tj/node-prune | sh && \
    node-prune

EXPOSE 3000

CMD [ "npm", "run", "dev" ]