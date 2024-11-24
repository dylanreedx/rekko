CREATE MIGRATION m1vpvyg4f77br2h6foh7ls62cgjz7jhffqen3h3y6yzyk7zvtbwfjq
    ONTO m1zliy6xccbh3nxiyiwzz3rwfszax5wg6wkmq36434aqtszbxjgnnq
{
  CREATE FUTURE nonrecursive_access_policies;
  CREATE TYPE default::Account {
      CREATE REQUIRED PROPERTY provider: std::str;
      CREATE REQUIRED PROPERTY providerAccountId: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE CONSTRAINT std::exclusive ON ((.provider, .providerAccountId));
      CREATE REQUIRED LINK user: default::User {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE REQUIRED PROPERTY userId := (.user.id);
      CREATE PROPERTY access_token: std::str;
      CREATE PROPERTY createdAt: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE PROPERTY expires_at: std::int64;
      CREATE PROPERTY id_token: std::str;
      CREATE PROPERTY refresh_token: std::str;
      CREATE PROPERTY scope: std::str;
      CREATE PROPERTY session_state: std::str;
      CREATE PROPERTY token_type: std::str;
      CREATE REQUIRED PROPERTY type: std::str;
  };
  ALTER TYPE default::User {
      CREATE MULTI LINK accounts := (.<user[IS default::Account]);
  };
  CREATE TYPE default::Session {
      CREATE REQUIRED LINK user: default::User {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE REQUIRED PROPERTY userId := (.user.id);
      CREATE PROPERTY createdAt: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY expires: std::datetime;
      CREATE REQUIRED PROPERTY sessionToken: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  ALTER TYPE default::User {
      CREATE MULTI LINK sessions := (.<user[IS default::Session]);
      CREATE PROPERTY createdAt: std::datetime {
          SET default := (std::datetime_current());
      };
      ALTER PROPERTY email {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE PROPERTY emailVerified: std::datetime;
      CREATE PROPERTY image: std::str;
      ALTER PROPERTY name {
          RESET OPTIONALITY;
      };
  };
  CREATE TYPE default::VerificationToken {
      CREATE REQUIRED PROPERTY identifier: std::str;
      CREATE REQUIRED PROPERTY token: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE CONSTRAINT std::exclusive ON ((.identifier, .token));
      CREATE PROPERTY createdAt: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY expires: std::datetime;
  };
  DROP EXTENSION auth;
  DROP EXTENSION pgcrypto;
};
