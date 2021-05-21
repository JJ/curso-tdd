# -*- coding: utf-8 -*-
"""
Created on March 2021
@author: mariosky

Searches for markdown files in the current repo,
then it extracts the rendered markdown leaving only the basic html version,
then it extracts all html tags and sends the body to the redis-search server.


We need to add SEARCH_HOST and  API_USER_PASSWORD secret variables in our repo.
These are defined in main.yml.
"""

from github import Github
import os
import requests

from bs4 import BeautifulSoup
import time


g = Github( os.getenv("GITHUB_TOKEN"))
repo = g.get_repo(os.getenv("GITHUB_REPO"))

contents = repo.get_contents("")
while contents:

    file_content = contents.pop(0)
    if file_content.type == "dir":
        contents.extend(repo.get_contents(file_content.path))
    else:
        if file_content.path[-3:] == ".md":
            html_doc = g.render_markdown(file_content.decoded_content.decode("utf-8"))
            #soup = BeautifulSoup(html_doc, 'html.parser')
            #text = soup.get_text()

            payload = {'url': file_content.html_url,
                       'title': file_content.name,
                       'body': html_doc
                      }
            r = None
            try:
                r = requests.post('http://{}:5000/add-md-document'.format(os.getenv("SEARCH_HOST")),
                              json=payload,
                              auth=('user', os.getenv("API_USER_PASSWORD")),
                              timeout=1)
                print(file_content.name, r.status_code)

            except requests.exceptions.Timeout:
                print("Server timout")
            time.sleep(1)

print("upload finished")