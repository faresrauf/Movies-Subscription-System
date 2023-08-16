/*eslint-disable*/
import { Inject } from "@nestjs/common";
import { DataSource, Repository } from "typeorm";

export class RepositoryUtil {
    constructor(
        @Inject('DATA_SOURCE') private readonly datasource: DataSource
    ) {}
    getRepository<T>(entity): Repository<T> {
        return this.datasource.getRepository(entity);
    }
    
}