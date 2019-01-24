# Networking

The data from most applications comes from an external data source, most likely "The Cloud".

## HTTP

Hyper-Text Transfer Protocol

* HTML Hyper-Text Markup Language
* Transfer the ability to send and receive data 
* Protocol set of rules to follow not to be confused with `@protocol`

### HTTP Methods

out of all the different HTTP methods, there are two most important ones:

* GET get data from a server 
* POST anything else

Out of those, GET requests are the most common. 


### KKJP

* Knock Knock
* Who's There?
* kgb
* kgb who?
* (slap the second person and say) we will ask the questions here.

## HTTP headers

in the http headers we can specify extra data to be sent to the server

`content-type: application/json`

## JSON

JavaScript Object Notation

```json
{
  "results": [
    {
      "name": "Luke Skywalker",
      "height": "172",
    }
  ]
}
```

```objc
data[@"results"][0][@"name"]; // Luke Skywalker
```

`NSDictionary` & `NSArray`

`JSONSerialization`


## HTTP request tools

* https://www.getpostman.com/
* `curl`
* install `jsonpp`

```
--verbose
--request POST
--data '{}'
--headers 
```

`curl --request GET --header "accept: application/json" https://swapi.co/api/people/ | jsonpp `

## Status Codes

* 200 OK

## Multithreading

All UI updates must happen on the main queue.

```objc
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
  [self.tableView reloadData];
}];
```
    