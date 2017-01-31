---
title: Error Messages
position: 3
---

| Error                                | Description                                           |
|--------------------------------------|-------------------------------------------------------|
| unpermitted parameters               | Request contains unpermitted parameters               |
| [PARAMETER] parameter value is empty | Request contains permitted parameters that are empty  |

All errors will return JSON in the following format:

~~~ json
{
  "error": "error message here"
}
~~~
