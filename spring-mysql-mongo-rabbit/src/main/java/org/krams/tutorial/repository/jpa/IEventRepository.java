package org.krams.tutorial.repository.jpa;

import org.krams.tutorial.domain.Event;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * A repository for {@link Event}
 * 
 * @author krams at {@link http://krams915@blogspot.com}
 */
public interface IEventRepository extends JpaRepository<Event, Long> {
}
