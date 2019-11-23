# OpenWeather
This application developed without using a storyboard. The first window starts by AppDelegate window property. All api request runs with Service singleton pattern.

## Screenshots
|      Screen       | Main Screen       | 
|-------------------|------------------:|
|    ![screen][]    | ![main-screen][]  |

## Sample of api url
- **Weather json url**: 
 http://api.openweathermap.org/data/2.5/forecast/daily?q={city_name}&units=metric&cnt=7&appid={api_key}

## Sample of api json
Weather json data;
```json
{
  "city": {
    "id": 323786,
    "name": "Ankara",
    "coord": {
      "lon": 32.8538,
      "lat": 39.9215
    },
    "country": "TR",
    "population": 3517182,
    "timezone": 10800
  },
  "cod": "200",
  "message": 1.1619921,
  "cnt": 7,
  "list": [
    {
      "dt": 1574499600,
      "sunrise": 1574484130,
      "sunset": 1574519274,
      "temp": {
        "day": 7.69,
        "min": 5.96,
        "max": 7.69,
        "night": 5.96,
        "eve": 7.69,
        "morn": 7.69
      },
      "pressure": 1017,
      "humidity": 39,
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "broken clouds",
          "icon": "04n"
        }
      ],
      "speed": 0.77,
      "deg": 197,
      "clouds": 65
    },
  ]
}
```

[screen]: https://github.com/perpeer/OpenWeather/blob/master/images/screen.gif?raw=true
[main-screen]: https://github.com/perpeer/OpenWeather/blob/master/images/MainScreen.png?raw=true