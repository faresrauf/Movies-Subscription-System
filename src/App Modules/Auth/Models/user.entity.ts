/* eslint-disable */
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('useraccount')
export class UserAccount {
  @PrimaryGeneratedColumn()
  userid: number;

  @Column({ length: 30 })
  name: string;

  @Column({ length: 64 })
  email: string;

  @Column({ length: 20 })
  username: string;

  @Column({ length: 100 })
  password: string;

  @Column({ length: 255, nullable: true })
  billingaddress: string;

  @Column({ default: 'user' })
  role: string;
}
