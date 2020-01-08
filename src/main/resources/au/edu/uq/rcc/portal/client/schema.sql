--
-- NB: Basic Spring Session Tables, cleaned up a bit.
--

DROP TABLE IF EXISTS SPRING_SESSION CASCADE;
CREATE TABLE SPRING_SESSION (
	PRIMARY_ID				TEXT NOT NULL PRIMARY KEY,
	SESSION_ID				TEXT NOT NULL UNIQUE,
	CREATION_TIME			BIGINT NOT NULL,
	LAST_ACCESS_TIME		BIGINT NOT NULL,
	MAX_INACTIVE_INTERVAL	INT NOT NULL,
	EXPIRY_TIME				BIGINT NOT NULL,
	PRINCIPAL_NAME			TEXT
);
CREATE INDEX ON SPRING_SESSION(EXPIRY_TIME);
CREATE INDEX ON SPRING_SESSION(PRINCIPAL_NAME);

DROP TABLE IF EXISTS SPRING_SESSION_ATTRIBUTES CASCADE;
CREATE TABLE SPRING_SESSION_ATTRIBUTES (
	SESSION_PRIMARY_ID TEXT NOT NULL REFERENCES SPRING_SESSION(PRIMARY_ID) ON DELETE CASCADE,
	ATTRIBUTE_NAME TEXT NOT NULL,
	ATTRIBUTE_BYTES BYTEA NOT NULL,
	PRIMARY KEY(SESSION_PRIMARY_ID, ATTRIBUTE_NAME)
);

-- FIXME: Shouldn't be here, see ClientEndpoints.java
DROP TABLE IF EXISTS preferences CASCADE;
CREATE TABLE preferences(
	id			BIGSERIAL NOT NULL PRIMARY KEY,
	uid			TEXT NOT NULL,
	provider	TEXT NOT NULL,
	data		JSONB NOT NULL,
	UNIQUE(uid, provider)
);