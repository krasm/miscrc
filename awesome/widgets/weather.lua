local json = require("JSON")

local apikey = os.getenv("OPENWEATHER_API_KEY")
local lon = os.getenv("OPENWEATHER_LAT")
local lat = os.getenv("OPENWEATHER_LON")

local symbols = {
    ["01d"] = "\u{263c}",
    ["01n"] = "\u{263c}",
    ["02d"] = "\u{1f324}",
    ["02n"] = "\u{1f324}",
    ["03d"] = "\u{1f325}",
    ["03n"] = "\u{1f325}",
    ["04d"] = "\u{2601}",
    ["04n"] = "\u{2601}",
    ["09d"] = "\u{1f326}",
    ["09n"] = "\u{1f326}",
    ["10d"] = "\u{1f327}",
    ["10n"] = "\u{1f327}",
    ["11d"] = "\u{1f329}",
    ["11n"] = "\u{1f329}",
    ["13d"] = "\u{1f328}",
    ["13n"] = "\u{1f328}",
    ["50d"] = "\u{1f32b}",
    ["50n"] = "\u{1f32b}",
}

local function get_icon(icon)
    return symbols[icon]
end

local function get_temp(temp)
    return string.format("%.1f", temp - 273.15)
end

local function get_wind(wind)
    return string.format("%.1f", wind)
end

local function get_gust(gust)
    return string.format("%.1f", gust)
end

local function get_desc(desc)
    return string.format("%s", desc)
end

local function parse(raw)
    if not raw then return {} end
    local data = json:decode(raw)

    return {
        icon = get_icon(data.current.weather[1].icon),
        temp = get_temp(data.current.temp),
        feels = get_temp(data.current.feels_like),
        wind = get_wind(data.current.wind_speed),
        gust = get_gust(data.current.wind_gust),
        desc = get_desc(data.current.weather[1].description),
    }
end

local function get()
    local url = string.format(
        "https://api.openweathermap.org/data/3.0/onecall?lat=%f&lon=%f&exclude=minutely,hourly&appid=%s",
        lat, lon, apikey)
    print(url)
    local r = io.popen("curl -fs -H 'Accept: application/json' '" .. url .. "'")
    local raw = r:read("*a")
    r:close()

    print(raw)

    return parse(raw)
end

return {
    get = get
}

