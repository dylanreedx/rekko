CREATE MIGRATION m1zliy6xccbh3nxiyiwzz3rwfszax5wg6wkmq36434aqtszbxjgnnq
    ONTO initial
{
  CREATE EXTENSION pgcrypto VERSION '1.3';
  CREATE EXTENSION auth VERSION '1.0';
  CREATE TYPE default::User {
      CREATE REQUIRED PROPERTY email: std::str;
      CREATE REQUIRED PROPERTY name: std::str;
  };
};
