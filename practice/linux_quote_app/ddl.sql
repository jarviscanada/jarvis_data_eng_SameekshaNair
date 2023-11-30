CREATE TABLE quotes (
                        id SERIAL PRIMARY KEY,
                        symbol VARCHAR(10) NOT NULL,
                        open NUMERIC(12, 4),
                        high NUMERIC(12, 4),
                        low NUMERIC(12, 4),
                        price NUMERIC(12, 4),
                        volume BIGINT
);