---
title: /states
position: 1.0
type: get
description: List all states
right_code: |
  Example Response  
    
  ~~~ json
  {
    "data": {
      "negeri": [
        "labuan",
        "terengganu",
        "sarawak",
        "putrajaya",
        "kuala lumpur",
        "selangor",
        "sabah",
        "perak",
        "pulau pinang",
        "perlis",
        "pahang",
        "negeri sembilan",
        "melaka",
        "kelantan",
        "kedah",
        "johor"
      ]
    }
  }
  ~~~
  {: title="All States" }

  ~~~ json
  {
    "data": {
      "negeri": {
      "nama": "selangor",
      "zon": [
          "sabak bernam",
          "kuala selangor",
          "klang",
          "kuala langat",
          "gombak",
          "h. selangor",
          "rawang",
          "h. langat",
          "sepang",
          "petaling",
          "s. alam"
        ]
      }
    }
  }
  ~~~
  {: title="By State" }

---
##### Endpoint
`https://waktu-solat-api.herokuapp.com/api/v1/states.json`

negeri (optional)
: filter state by its name and list its zones

##### Examples

~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/states.json
~~~
{: title="All States" }

~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/states.json?negeri=STATE_NAME
~~~
{: title="Filter by State" }
