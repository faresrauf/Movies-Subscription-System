/* eslint-disable */
import { Global, Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { DatabaseModule } from './Shared Modules/Database/database.module';
import { AuthModule } from './App Modules/Auth/auth.module';
import { EmailModule } from './Shared Modules/Email/email.module';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from './Shared Modules/Guards/roles.guard';
import { UsersModule } from './App Modules/User Accounts/users.module';
import { JwtAuthGuard } from './Shared Modules/Guards/jwt.guard';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from './Shared Modules/Passport/jwt.strategy';

@Global()
@Module({
  imports: [DatabaseModule, EmailModule, AuthModule, JwtModule.register({
    secret: process.env.SECRET_KEY,
    signOptions: {
      expiresIn: '3600s'
    }
  }), UsersModule],
  providers: [
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    }, JwtStrategy,
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    }
  ],
  controllers: [AppController],
})
export class AppModule { }
