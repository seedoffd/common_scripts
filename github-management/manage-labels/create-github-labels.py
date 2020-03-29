import requests
import os
import json
import logging 
from github import Github

owner = os.environ.get("GIT_ORG")
token = os.environ.get("GIT_TOKEN")

with open('github-management/manage-labels/labels.json') as file:
    labels = json.load(file)

g = Github(token)
org = g.get_organization('fuchicorp')
repos = org.get_repos()

for repo in repos:
    for label in labels:
        try:
            repo.create_label(label['name'], label['color'], label['description'])
            logging.warning(f"{label['name']} label has been created to {repo.name}")
        except Exception as e:
            logging.error(repo.name) 
            logging.error(e)