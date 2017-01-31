---
title: /zones
position: 1.1
type: get
description: List all zones
right_code: |
  Example Response  
    
  ~~~ json
  {
    "data": {
      "zon": [
        "lumut",
        "labuan",
        "kemaman dungun",
        "hulu terengganu",
        "besut",
        "setiu",
        "kuala terengganu",
        "marang",
        ...,
        "mersing",
        "johor bahru",
        "pulau aur",
        "pemanggil"
      ]
    }
  }
  ~~~
  {: title="All Zones" }

  ~~~ json
  {
    "data": {
      "negeri": "selangor",
      "zon": "sepang"
    }
  }
  ~~~
  {: title="By Zone" }

---
##### Endpoint
`https://waktu-solat-api.herokuapp.com/api/v1/zones.json`

zon (optional)
: filter zone by its name and get its corresponding state

##### Examples
~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/zones.json
~~~
{: title="All Zones" }

~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/zones.json?zon=ZONE_NAME
~~~
{: title="Filter by Zone" }
