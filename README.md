# Fluke

## Dependencies:
- Node 20>= (javascript runtime)
- PostgreSQL (database)
- Docker (for unit testing, containerization)
- Sonar scanner (Optional)

## Development

1. Create a `.env` file using `.env.sample` and fill your database details.

2. Start the app

    `npm start -- --migrate clean_and_migrate`
    
If everything goes well, you should see the app at `localhost:8000`.

## JWT Key Pair

- For authentication of secured api routes we have used JWT tokens.
- For creation and verification of JWT token we have user ES512 algorithm.
  
  Commands to create JWT token key pair.

  `openssl ecparam -genkey -name secp521r1 -noout -out jwt-private.pem`

  `openssl ec -in jwt-private.pem -pubout > jwt-public.pem`

- After getting the public and private keys, update them in the `.env` file 
- While updating use double quotes to escape the newlines, it should look like

    ```sh
    JWT_PRIVATE_KEY="-----BEGIN EC PRIVATE KEY-----
    Some key string here"
    ```

## NPM Scripts

1. `npm run create:migration YOUR_MIGRATION_NAME`
   
   This command will create your migration in migrations directory along with up and down migration SQLs in migrations/sqls directory.

2. `npm run db:migrate`
   
    This command will run your up migration in migrations directory.

3. `npm run db:migrate-down`
   
    This command will run your down migration in migrations directory. All of the down migrations work identically to the up migrations by substituting the word down for up.

4. `npm run db:clean`

    This command will clean your database. It uses down migration to clean up the database.


5. `npm start`
   
    Starts the development server

6. `npm start -- --migrate migrate`

    This command will start your application and run migrations before starting server.

7. `npm start -- --migrate clean_and_migrate`

    This command will start your application and clean db plus run migrations before starting server.

8. `npm run lint`

    This command would show you linting errors in console log.
   
