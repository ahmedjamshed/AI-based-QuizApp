import requests
import json


def wikiPage(title):
    url = 'https://en.wikipedia.org/w/api.php'
    data = {
        'action': 'query',
        'format': 'json',
        'formatversion': 2,
        'prop': 'pageimages|pageterms',
        'piprop': 'original',
        'titles': title
    }
    response = requests.get(url, data)
    json_data = json.loads(response.text)
    print(json_data)
    return json_data['query']['pages'][0]['original']['source'] if len(json_data['query']['pages']) > 0 else 'Not found'
