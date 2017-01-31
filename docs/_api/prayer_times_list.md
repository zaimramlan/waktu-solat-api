---
title: /prayer_times
position: 1.2
type: get
description: List all prayer times
right_code: |
  Example Response  
    
  ~~~ json
  {
    "data": {
      "negeri": [
        {
          "nama": "labuan",
          "zon": [
            {
              "nama": "labuan",
              "waktu_solat": [
                {
                  "name": "imsak",
                  "time": "05:06"
                },
                ...,
                {
                  "name": "isyak",
                  "time": "19:42"
                }
              ]
            }
          ]
        },
        ...,
        {
          "nama": "johor",
          "zon": [
            ...,
            {
              "nama": "pemanggil",
              "waktu_solat": [
                {
                  "name": "imsak",
                  "time": "05:46"
                },
                ...,
                {
                  "name": "isyak",
                  "time": "20:29"
                }
              ]
            }
          ]
        }
      ]
    }
  }
  ~~~
  {: title="All Prayer Times" }

  ~~~ json
  {
    "data": {
      "negeri": "selangor",
      "zon": [
        {
          "nama": "sabak bernam",
          "waktu_solat": [
            {
              "name": "imsak",
              "time": "06:01"
            },
            ...,
            {
              "name": "isyak",
              "time": "20:41"
            }
          ]
        },
        ...,
        {
          "nama": "s. alam",
          "waktu_solat": [
            {
              "name": "imsak",
              "time": "05:59"
            },
            ...,
            {
              "name": "isyak",
              "time": "20:39"
            }
          ]
        }
      ]
    }
  }
  ~~~
  {: title="By State" }

  ~~~ json
  {
    "data": [
      {
        "negeri": "selangor",
        "zon": "sepang",
        "waktu_solat": [
          {
            "name": "imsak",
            "time": "05:59"
          },
          {
            "name": "subuh",
            "time": "06:09"
          },
          {
            "name": "syuruk",
            "time": "07:26"
          },
          {
            "name": "zohor",
            "time": "13:29"
          },
          {
            "name": "asar",
            "time": "16:51"
          },
          {
            "name": "maghrib",
            "time": "19:27"
          },
          {
            "name": "isyak",
            "time": "20:39"
          }
        ]
      }
    ]
  }
  ~~~
  {: title="By Zone" }  

  ~~~ json
  {
    "data": {
      "negeri": "selangor",
      "zon": [
        {
          "nama": "sepang",
          "waktu_solat": [
            {
              "name": "imsak",
              "time": "05:59"
            },
            {
              "name": "subuh",
              "time": "06:09"
            },
            {
              "name": "syuruk",
              "time": "07:26"
            },
            {
              "name": "zohor",
              "time": "13:29"
            },
            {
              "name": "asar",
              "time": "16:51"
            },
            {
              "name": "maghrib",
              "time": "19:27"
            },
            {
              "name": "isyak",
              "time": "20:39"
            }
          ]
        }
      ]
    }
  }
  ~~~
  {: title="By State & Zone" }    

---

##### Endpoint
`https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json`

negeri (optional)
: list prayer times by state

zon (optional)
: list prayer times by zone

##### Examples

~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json
~~~
{: title="All Prayer Times" }

~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json?negeri=STATE_NAME
~~~
{: title="By State" }

~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json?zon=ZONE_NAME
~~~
{: title="By Zone" }

~~~ bash
curl https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json?negeri=STATE_NAME&zon=ZONE_NAME
~~~
{: title="By State & Zone" }
