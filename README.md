# Waktu Solat API

![](https://github.com/zaimramlan/waktu-solat-api/blob/master/docs/images/waktu-solat-api.png)

Malaysia prayer times (waktu solat) JSON API @ E-Solat API. Data from [JAKIM's E-Solat](http://www.e-solat.gov.my).

## Built with Waktu Solat API

[Waktu Solat Malaysia Telegram Bot](https://waktusolatbot.my) by [Zaim Ramlan](https://github.com/zaimramlan)

## About

- Built with Ruby (2.3.1) on Rails (5.0.1)  
- Deployed on Heroku on midnight of 01 Feb 2017
- Data updates every midnight

## Documentation

[https://zaimramlan.github.io/waktu-solat-api/](https://zaimramlan.github.io/waktu-solat-api/)

## Endpoints

1. https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json
2. https://waktu-solat-api.herokuapp.com/api/v1/zones.json
3. https://waktu-solat-api.herokuapp.com/api/v1/states.json

## Changelogs

**v1.2.2 - 06/04/2019**
- Resolve minor issue

**v1.2.1 - 04/01/2019**
- Resolve minor issue

**v1.2.0 - 04/01/2019**
- Added v2 scraper to scrape from e-solat's new format

**v1.1.0 - 02/09/2018**
- Added backup scraper to scrape from a backup source

**v1.0.1 - 15/01/2018**
- Modify sanitiser to offset incorrect prayer times

**v1.0.0 - 01/02/2017**
- Initial API Release

## Improvements

- Pagination for `/prayer_times.json`

## Contributing

Do fork this project and improve where you see fit. Submit your Pull Request for merge review.  
<sup>Use the [prepare repository](https://github.com/zaimramlan/waktu-solat-api#prepare-repository) section to help setup the repo on your local environment.</sup>

## Prepare Repository

Clone the repo and install the dependencies  

``` bash
$ git clone https://github.com/zaimramlan/waktu-solat-api.git
$ cd waktu-solat-api
$ bundle install
```

Set up the database  

``` bash
$ rake db:create db:migrate
```

Download the list of states, zones and prayer times  

``` bash
$ rake esolat:v2:scrapezones esolat:v2:scrapetimes
```

Run the Server  

``` bash
$ rails server
```

## License

- MIT
