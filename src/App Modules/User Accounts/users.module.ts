/* eslint-disable */
import { Module } from "@nestjs/common";
import { UsersService } from "./users.service";
import { UsersController } from "./users.controller";
import { APP_INTERCEPTOR } from "@nestjs/core";
import { EnrichUserInterceptor } from "src/Shared Modules/Interceptors/RequestEnrichInterceptor";

@Module({
    providers: [UsersService],
    controllers: [UsersController],
  })
  export class UsersModule {}
  