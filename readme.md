# Test Inch

This is a sandbox rails project for a mini challenge by Inch

## Requirements

- ruby 2.5.1p57
- Rails 4.2.10

## Installation

```bash
git clone git@github.com:powerfulsheron/inch.git
cd inch
bundle install
```
## Run

```bash
rails s
```

## Test

```bash
bundle exec rspec
```

## Usage

After running `rails s` go to [localhost](http://localhost:3000) 
 
You can import csv's for persons and buildings via interface  

For manual updates please try the following cURL's :


```bash
curl --location --request PATCH 'http://localhost:3000/buildings?reference=1' \
--header 'Content-Type: application/json' \
--header 'Cookie: request_method=PATCH; _inch_session=cmFyWTRyZ0xiSzI5OGpqc2JLRWNLY0k3eFpHWWl5UjhxNkg3a3U4ZENKV3JSMVphaEQyUXdTTGFPUVJwTzJqaVViZEh0UGROQzkwYWNMcE5zY3VNQ1loSUc0YWdobGFheFVYN1JoVnhUZFFFSENWeVEzK2lGZjFpMUh6NERQQndSWEVPZkVzb1hsZTBCamRsbGhTd0NnPT0tLUh5UUw1UmUyY0kzQXZWNTVKcUIyOHc9PQ%3D%3D--f8ccd60818ac28c690dd054bcb478a530e6c921c' \
--data-raw '{
    "manager_name":"weeb"
}'
```


```bash
curl --location --request PATCH 'http://localhost:3000/persons?reference=1' \
--header 'Content-Type: application/json' \
--header 'Cookie: request_method=PATCH; _inch_session=ckgvV1NCd3BNTGwvWkk2N2k2clVjY3BjOGJoU1lmc3lCT0NuTVdEUG1QdzF4bnBQYndDaU9OYUFnZUw3NlpiQlJKNm5NcUtDeXA1S1F4OWZuS2NhbFJNTHFUd28vR0NoZUhleFhHemNIR0xLVXF3NzY3QnZHYnZqb0J3TUY3SGYyV3U3NEIwcHc1S2RKRmtMNmV5Z2J3PT0tLTh4UFVKbnN3TGx6WFJmTElJdXVITFE9PQ%3D%3D--e448798ede4e42592713218ac62eb64aa168bbdb' \
--data-raw '{
    "email":"tupacshakur75@gmail.com"
}'
```

I guess that's it lol
