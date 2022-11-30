FROM node:16

WORKDIR /home/web-express-deskpower

COPY . .

RUN npm i -g pnpm
RUN pnpm i
RUN pnpm build

EXPOSE 2783
CMD ["pnpm", "start"]