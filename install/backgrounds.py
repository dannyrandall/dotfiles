#!/usr/bin/env python3

import os
import json
import requests
import random
import glob

PHOTO_DIR="/home/dannyrandall/pictures/backgrounds"

API_ADDR = os.environ["UNSPLASH_API_ADDR"]
CLIENT_ID = os.environ["UNSPLASH_CLIENT_ID"]

REQ_HEADERS = {
    "Accept-Version": "v1",
    "Authorization": "Client-ID {}".format(CLIENT_ID)
}

class Collection:
    def __init__(self, ID, title):
        self.ID = ID
        self.title = title
        self.photos = None

    def __str__(self):
        return "ID:{}, Title:{}".format(self.ID, self.title)


    def getPhotos(self):
        print("getting photos for collection: {}".format(self.title))

        photos = []
        
        json = apirequest("/collections/{}/photos?per_page=50".format(self.ID))
         
        if type(json) != None:
            for photo in json:
                p = Photo(photo["id"], photo["urls"]["full"])
                photos.append(p)
    
        self.photos = photos


    def download(self, basedir=PHOTO_DIR):
        cdir = "{}/{}".format(basedir, self.title)

        print("downloading photos to: {}".format(cdir))

        # create the directory or wipe it
        if os.path.exists(cdir):
            print("\tcleaning collection directory...")

            files = glob.glob("{}/*.jpg".format(cdir))
            for f in files:
                print("\t\tremoving {}".format(f))
                os.remove(f)
        else:
            print("\tcreating directory...")
            os.makedirs(cdir)
        
        print("\tdownloading photos...")
        # download the photos
        for p in self.photos:
            p.download(cdir)

        print("success!")


class Photo:
    def __init__(self, ID, url):
        self.ID = ID
        self.url = url

    def __str__(self):
        return "ID:{}, URL:{}".format(self.ID, self.url)


    def download(self, directory, extension="jpg"):
        print("\t\tdownloading photo {}.{} from {}".format(self.ID, extension, self.url))

        loc = "{}/{}.{}".format(directory, self.ID, extension)
        p = requests.get(self.url)

        with open(loc, "wb") as f:
            f.write(p.content)


def getRandomCollection():
    print("getting a random collection")

    json = apirequest("/collections/featured?per_page=100")
    if type(json) != None:
        # pick a random index in the array of collections
        idx = random.randint(0, len(json)-1)
        
        # return collection id of that item
        c = Collection(json[idx]["id"], json[idx]["title"])
        return c
    else:
        return None 


def apirequest(endpoint):
    url = "{}{}".format(API_ADDR, endpoint)

    response = requests.get(url, headers=REQ_HEADERS)

    if response.status_code == 200:
        return json.loads(response.content.decode('utf-8'))
    else:
        return None

c = getRandomCollection()
c.getPhotos()
c.download()
