import requests
import json


class Topics:
    def __init__(self, title, desc):
        self.title = title
        self.description = desc
        self.subTopics = []


def wikiPage(title):
    url = 'https://en.wikipedia.org/w/api.php'
    data = {
        'action': 'query',
        'format': 'json',
        'formatversion': 2,
        'prop': 'pageimages|pageterms|extracts',
        # 'explaintext': True,
        'piprop': 'original',
        'titles': title
    }
    response = requests.get(url, data)
    json_data = json.loads(response.text)
    page = json_data['query']['pages'][0]
    extract = page['extract']
    return {'page': page, 'extract': extract}
