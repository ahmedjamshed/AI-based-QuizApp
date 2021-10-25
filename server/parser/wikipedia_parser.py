from bs4 import *
import requests
import re


class Topics:
    def __init__(self, title, desc):
        self.title = title
        self.description = desc
        self.subTopics = []


def cleanString(para: str):
    out = para.strip()
    out = re.sub("[\(\[].*?[\)\]]", "", out)
    out = re.sub(' +', " ", out)
    return out


def wikiHtmlParser(html, head):
    soup = BeautifulSoup(html, 'html.parser')
    heading = head
    subheading = ''
    description = ''

    for tag in soup.find_all():
        if 'See_also' == tag.id:
            print(tag.text)
        elif "h" in tag.name:
            print('\n\n')
            print(heading)
            print('\t' + subheading)
            print(description)
            print('\n\n')
            description = ''
            if "h2" == tag.name:
                heading = tag.text
                subheading = ''
            elif "h3" == tag.name:
                subheading = tag.text
        elif tag.name == "p":
            description += tag.text

    return []


def wikipedia(pageUrl):
    r = requests.get(pageUrl)
    # Get body content
    soup = BeautifulSoup(r.text, 'html.parser').select('body')[0]

    # Initialize variable
    paragraphs = []
    images = []
    link = []
    heading = []
    remaining_content = []

    # Iterate throught all tags
    for tag in soup.find_all():

        # Check each tag name
        # For Paragraph use p tag
        if tag.name == "p":

            # use text for fetch the content inside p tag
            paragraphs.append(tag.text)

        # For Image use img tag
        elif tag.name == "img":

            # Add url and Image source URL
            images.append(pageUrl+tag['src'])

        # For Anchor use a tag
        elif tag.name == "a":

            # convert into string and then check href
            # available in tag or not
            if "href" in str(tag):

                # In href, there might be possible url is not there
                # if url is not there
                if "https://en.wikipedia.org/w/" not in str(tag['href']):
                    link.append(pageUrl+tag['href'])
                else:
                    link.append(tag['href'])

        # Similarly check for heading
        # Six types of heading are there (H1, H2, H3, H4, H5, H6)
        # check each tag and fetch text
        elif "h" in tag.name:
            if "h1" == tag.name:
                heading.append(tag.text)
            elif "h2" == tag.name:
                heading.append(tag.text)
            elif "h3" == tag.name:
                heading.append(tag.text)
            elif "h4" == tag.name:
                heading.append(tag.text)
            elif "h5" == tag.name:
                heading.append(tag.text)
            else:
                heading.append(tag.text)

        # Remain content will store here
        else:
            remaining_content.append(tag.text)

    paragraphs = filter(lambda para: len(para) > 5,  paragraphs)
    paragraphs = list(map(lambda para: cleanString(para), paragraphs))
    return {'paragraphs': paragraphs, 'images': images}
