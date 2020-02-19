# dbt-xdb
_Cross-database support for dbt_

This package is designed to make your sql purely portable in the DRYest possible way. 

### Installing xdb

in your `packages.yml` add this line:

```

  - git: "https://github.com/norton120/dbt-xdb.git"
    revision: 0.0.1

```
(_no worries, this will be published to dbt hub very very soon_.)


### Using xdb

`xdb` macros are written as close to ansii spec as possible. 
For something like `regexp` searching to see if the case-insensitive username starts with "soup":

```
    ...
    CASE
        WHEN {{xdb.regexp('username','soup.*','i')}} THEN 'Is Soup User'
        ELSE 'Not Soup User'
    END AS soup_user 

```

### Why use xdb? 

Vendor-specific SQL is a relationship. 
Using xdb is like a prenuptual agreement for your code; because no matter how much you love your data warehouse vendor today, it is better to be safe than sorry. 

### Developing XDB
To get started clone this repo with 

```

git clone git@github.com:norton120/dbt-xdb.git

```

Then set up your `profiles.yml` file and freeze it with 

```

git update-index --assume-unchanged profiles.yml

```
**Note:** each target you set up in `profiles.yml` will get tested. So if you have access to a BigQuery, Redshift _and_ Snowflake instance, you can test them all! Since both AWS and GCP have a lot of free development credits for new accounts, this is not as heavy a lift as it sounds. 

On to the dev! 
This dev env uses Docker. Start your env with:

```

docker-compose up -d

```

then get rolling with 

```

docker-compose exec testxdb python3 scripts/test_setup.py

```

(you only do this __once__ when you first start the container.)

From here you can run the tests with

```

docker-compose exec testxdb python3 scripts/test_run.py

```

Which does a dbt run and dbt test and returns results. 

To test your macros:

- write your `xdb` macro in `xdb/macros/`. 
- build a model in `test_xdb/models/under_test/` that uses the macro with the simplest possible case using the sample data.
- add tests to confirm the macro works in `test_xdb/models/under_test/schema.yml`.
