import requests
import os

organization = 'fuchicorp'
token = os.environ.get('gittoken')

def get_org_projects(organization):

    url = f'https://api.github.com/orgs/{organization}/'
    resp = requests.get(url=url, headers={"Authorization": "token $gittoken", "Content-Type" : "application/vnd.github.inertia-preview+json"})
    print(resp.json())


if __name__ == '__main__':
    get_org_projects(organization)
