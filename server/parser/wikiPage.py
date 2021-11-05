import requests
import json
from parser.wikipedia_parser import wikiHtmlParser


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
    extract = page.pop('extract', '')
    topics = wikiHtmlParser(extract, title)
    return {'page': page, 'topics': topics}


def wikiPages(titles):
    titlesStr = '|'.join(titles)
    url = 'https://en.wikipedia.org/w/api.php'
    data = {
        'action': 'query',
        'format': 'json',
        'formatversion': 2,
        'prop': 'pageimages',
        # 'explaintext': True,
        'piprop': 'original',
        'titles': titlesStr
    }
    response = requests.get(url, data)
    json_data = json.loads(response.text)
    return list(json_data['query']['pages'])
