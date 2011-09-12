package org.krams.tutorial.repository.mongo;

import org.krams.tutorial.domain.ErrorLog;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @author krams at {@link http://krams915@blogspot.com}
 */
public interface IErrorLogRepository extends MongoRepository<ErrorLog, String> {
}
